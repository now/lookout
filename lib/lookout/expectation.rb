# -*- coding: utf-8 -*-

module Lookout::Expectation
  def self.on(expected, file, line, &block)
    case expected
    when Lookout::Recorder
      Lookout::Expectations::Behavior
    when Lookout::Warning
      Lookout::Expectations::State::Warning
    else
      Lookout::Expectations::State
    end.new(expected, file, line, &block)
  end

  def initialize(expected, file, line, &block)
    @expected, @file, @line, @block = expected, file, line, block
  end

  attr_reader :file, :line
end
