# -*- coding: utf-8 -*-

require 'benchmark'

class Lookout::Suite
  autoload :Results, 'lookout/suite/results'

  include Mocha::API

  def initialize
    @expectations = []
    @do_not_run = false
  end

  def xml(string)
    Lookout::XML.new(string)
  end

  def expect(expected, &block)
    file, line = *caller.first.match(/\A(.+):(\d+)/)[1..2]

    expected = Lookout::Literals.equalify(expected) unless expected.is_a? Lookout::Recorder

    if block.nil? and not expected.is_a? Lookout::Recorder
      expected = Lookout::Recorder.new(expected)
      expected.extend Lookout::Recorders::State
    end

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
      expectations_for(ENV["LINE"]).each do |expectation|
        result = expectation.execute
        ui.report result
        results << result
      end
    }
    results
  end

  def expectations_for(line)
    return expectations if line.nil?
    [expectations.inject{ |result, expectation| expectation.line > line.to_i ? result : expectation }]
  end

  attr_reader :expectations
end
