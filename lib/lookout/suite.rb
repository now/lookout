# -*- coding: utf-8 -*-

require 'benchmark'
require 'mocha'

class Lookout::Suite
  include Mocha::API

  autoload :Results, 'lookout/suite/results'

  class << self
    attr_accessor :silent
  end

  def initialize
    @do_not_run = false
  end

  def xml(string)
    Lookout::XmlString.new(string)
  end

  def execute(out=STDOUT, suite_result = Lookout::Suite::Results.new(out))
    return suite_result if @do_not_run
    benchmark = Benchmark.measure do
      expectations_for(ENV["LINE"]).each { |expectation| suite_result << expectation.execute }
    end
    suite_result.print_results(benchmark)
    suite_result.write_junit_xml(ENV["JUnitXmlPath"]) unless ENV["JUnitXmlPath"].nil?
    suite_result
  end

  def expect(expected, &block)
    file, line = *caller.first.match(/\A(.+):(\d+)/)[1..2]

    if block.nil? and not expected.is_a? Lookout::Recorder
      expected = Lookout::Recorder.new(expected)
      expected.extend(Lookout::Recorders::State)
    end

    expectations << Lookout::Expectation.new(expected, file, line, &block)

    expected
  end

  def do_not_run
    @do_not_run = true
  end

  def expectations_for(line)
    return expectations if line.nil?
    [expectations.inject { |result, expectation| expectation.line > line.to_i ? result : expectation }]
  end

  def expectations
    @expectations ||= []
  end

end
