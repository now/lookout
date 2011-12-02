# -*- coding: utf-8 -*-

module Lookout::Expectation
  @map = []

  class << self
    def map(from, to, options = {})
      if options[:before]
        i = @map.index{ |f, _| f == options[:before] } or
          raise ArgumentError,
            'cannot place expectation mapping before non-existent mapping: %p' %
              options[:before]
        @map[i, 0] = [[from, to]]
      else
        @map << [from, to]
      end
      self
    end

    def on(expected, file, line, &block)
      (((i = @map.index{ |from, _| from === expected }) and @map[i].last) or
       Lookout::Expectations::State).new(expected, file, line, &block)
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
