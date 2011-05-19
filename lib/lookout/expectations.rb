# -*- coding: utf-8 -*-

class Lookout::Expectations
  autoload :Behavior, 'lookout/expectations/behavior'
  autoload :State, 'lookout/expectations/state'

  include Enumerable

  def initialize
    @expectations = []
  end

  def mock
    Lookout::Mock::Object.new
  end

  def arg
    Lookout::Mock::Method::Arguments::Anything.new
  end

  def without_arguments
    Lookout::Mock::Method::Arguments::None.new
  end

  def stub
    Lookout::Stub::Object.new
  end

  def output(string)
    Lookout::Output.new(string)
  end

  def warning(string)
    Lookout::Warning.new(string)
  end

  def xml(string)
    Lookout::XML.new(string)
  end

  def expect(expected, &block)
    file, line = /\A(.*):(\d+)(?::in .*)?\z/.match(caller.first)[1..2]
    @expectations << Lookout::Expectation.on(expected, file, line, &block)
    expected
  end

  def evaluate(ui = Lookout::UI::Console.new, results = Lookout::Results.new)
    ui.start
    ui.summarize results, Lookout::Benchmark.time{
      each(ENV['LINE'] ? ENV['LINE'].to_i : nil) do |expectation|
        results << expectation.evaluate.tap{ |result| ui.report result }
      end
    }
    results
  end

  def each(line = nil)
    return enum_for(:each, line) unless block_given?
    (line ?
     Array(@expectations.reverse.find{ |e| e.line <= line }) :
     @expectations).each do |expectation|
      yield expectation
    end
    self
  end
end
