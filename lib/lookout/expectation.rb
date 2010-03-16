# -*- coding: utf-8 -*-

require 'mocha'

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
    Lookout.warn 'Use stubs, not mocks, inside tests', caller.first
    super
  end

  def ignore
    stub_everything
  end

  def execute
    mocha_setup
    warn_for_expects do
      execute_in_mocha
    end
    self
  ensure
    mocha_teardown
  end

  attr_reader :file, :line, :expected, :block

private

  def warn_for_expects
    Object.__which_expects__ = LookoutExpectsMethod
    yield
  ensure
    Object.__which_expects__ = MochaExpectsMethod
  end
end
