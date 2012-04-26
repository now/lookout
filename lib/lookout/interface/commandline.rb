# -*- coding: utf-8 -*-

class Lookout::Interface::Commandline
  def initialize(arguments = ARGV, pwd = Dir.pwd, io = $stderr)
    @pwd, @io = pwd, io
    @line = nil
    @files = []
    @requires = []
    @coverage = false
    only_load = false
    arguments.each do |argument|
      if not only_load and argument == '--'
        only_load = true
      elsif not only_load and argument =~ /\A-r(.*)/
        @requires << $1
      elsif not only_load and argument =~ /\A-l(.*)/
        @line = $1.to_i
      elsif not only_load and argument == '-c'
        @coverage = true
      elsif not only_load and argument =~ /\A-/
        raise ArgumentError, 'unknown option: %s' % argument
      else
        @files << [File.expand_path(argument, pwd), argument]
      end
    end
  end

  def call
    require
    coverage do
      return false unless expectations
    end
    true
  end

  private

  def require
    @requires.each do |feature|
      super feature
    end
  end

  def coverage
    return yield unless @coverage
    require 'coverage'
    Coverage.start
    yield
    Coverage.result.
      select{ |file, _| file.start_with? @pwd }.
      reject{ |file, _| files.assoc(file) }.
      sort.
      each do |file, counts|
        counts.
        each_cons(2).
        with_index.
        slice_before{ |(c1, c2), _| (c1 != 0 and c2 == 0) or (c1 == 0 and c2 != 0) }.
        select{ |e| e.first.first.last == 0 }.
        map{ |e| e.first.last+2..e.last.last+2 }.
        each do |lines|
          io.puts '%s:%s: not covered by test' %
            [relativize(file),
             lines.one? ? lines.begin : ('%d-%d' % [lines.begin, lines.end])]
        end
      end
  end

  def expectations
    passed = true
    @files.each do |expanded, file|
      expectations = Lookout::Expectations.new(expanded)
      if @line
        target = nil.to_lookout_expected.expect(expanded, @line){
          raise RuntimeError, 'line expectation not found: %s:%d' % [file, @line]
        }
        [(expectations.take_while{ |expect| expect <= target }.last or target)]
      else
        expectations
      end.each do |expect|
        result = expect.call
        next if Lookout::Results::Success === result
        passed = false
        @io.puts relativize(result.to_s)
      end
    end
    passed
  end

  def relativize(path)
    path.start_with?(@pwd) ? path[@pwd.length+1..-1] : path
  end
end
