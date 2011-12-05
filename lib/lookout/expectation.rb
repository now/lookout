# -*- coding: utf-8 -*-

module Lookout::Expectation
  class << self
    def on(expected, file, line, &block)
      expected.to_lookout_expectation(file, line, &block)
    # TODO: Enable something like this in the future.
    # rescue
    #   Lookout::Expectations::State.new(expected, file, line, &block)
    end
  end

  def initialize(expected, file, line, &block)
    @expected, @file, @line, @block = expected, file, line, block
  end

  include Comparable

  def <=>(other)
    [file, line] <=> [other.file, other.line]
  end

  protected

  attr_reader :file, :line
end
