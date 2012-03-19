# -*- coding: utf-8 -*-

require 'lookout'

line = nil
only_load = false
files = []
pwd = Dir.pwd
ARGV.each do |arg|
  if not only_load and arg == '--'
    only_load = true
  elsif not only_load and arg =~ /\A-r(.*)/
    require $1
  elsif not only_load and arg =~ /\A-l(.*)/
    line = $1.to_i
  elsif not only_load and arg == '-c'
    require 'coverage'
    Coverage.start
  else
    files << [File.expand_path(arg, pwd), arg]
  end
end

failed = false
files.each do |expanded, file|
  expectations = Lookout::Expectations.new(expanded)
  if line
    target = nil.to_lookout_expected.expect(expanded, line){
      raise RuntimeError, 'line expectation not found: %s:%d' % [file, line]
    }
    [(expectations.take_while{ |expect| expect <= target }.last or target)]
  else
    expectations
  end.each do |expect|
    result = expect.call
    next if Lookout::Results::Success === result
    failed = true
    message = result.to_s
    $stderr.puts message.start_with?(pwd) ? message[pwd.length+1..-1] : message
  end
end

Coverage.result.select{ |file, _| files.assoc(file) }.each do |file, counts|
  counts.
  each_cons(2).
  with_index.
  slice_before{ |(c1, c2), _| (c1 != 0 and c2 == 0) or (c1 == 0 and c2 != 0) }.
  select{ |e| e.first.first.last == 0 }.
  map{ |e| e.first.last+2..e.last.last+2 }.
  each do |lines|
    $stderr.puts '%s:%s: not covered by test' %
      [files.assoc(file).last,
       lines.one? ? lines.begin : ('%d-%d' % [lines.begin, lines.end])]
  end
end if defined? Coverage

exit false if failed
