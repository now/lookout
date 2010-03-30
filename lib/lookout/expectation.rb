# -*- coding: utf-8 -*-

module Lookout::Expectation
  include Mocha::API

  def self.on(expected, file, line, &block)
    (expected.is_a?(Lookout::Recorder) ?
     Lookout::Expectations::Behavior :
     Lookout::Expectations::State).new(expected, file, line, &block)
  end

  def initialize(expected, file, line, &block)
    @expected, @file, @line, @block = expected, file, line.to_i, block
  end

  def mock(*args)
    Lookout.warn 'use stubs, not mocks, inside tests', caller.first
    super
  end

  alias_method :ignore, :stub_everything

  def execute
    mocha_setup
    execute_in_mocha
    self
  ensure
    mocha_teardown
  end

  attr_reader :expected, :file, :line
end
