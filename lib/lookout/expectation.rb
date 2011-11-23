# -*- coding: utf-8 -*-

module Lookout::Expectation
  @map = []

  class << self
    def map(from, to)
      @map << [from, to]
    end

    def on(expected, file, line, &block)
      (((i = @map.find_index{ |from, _| from === expected }) and @map[i].last) or
       Lookout::Expectations::State).new(expected, file, line, &block)
    end
  end

  def initialize(expected, file, line, &block)
    @expected, @file, @line, @block = expected, file, line, block
  end

  attr_reader :file, :line
end
