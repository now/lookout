# -*- coding: utf-8 -*-

require 'benchmark'

class Lookout::Suite
  autoload :Results, 'lookout/suite/results'

  def initialize
    @expectations = []
    @do_not_run = false
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

  def xml(string)
    Lookout::XML.new(string)
  end

  def expect(expected, &block)
    file, colon, line = *caller.first.rpartition(':')
    expected = Lookout::Literals.equalify(expected) unless expected.is_a? Lookout::Recorder
    expectations << Lookout::Expectation.on(expected, file, line, &block)
    expected
  end

  def do_not_run
    @do_not_run = true
  end

  def execute(ui = Lookout::UI::Console.new, results = Lookout::Suite::Results.new)
    return results if @do_not_run
    ui.start
    ui.summarize results, Benchmark.realtime{
      expectations_for(ENV['LINE']).each do |expectation|
        results << expectation.execute.tap{ |result| ui.report result }
      end
    }
    results
  end

  def expectations_for(line)
    return expectations if line.nil?
    Array(expectations.inject{ |result, expectation| expectation.line > line.to_i ? result : expectation })
  end

  attr_reader :expectations
end
