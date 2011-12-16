# -*- coding: utf-8 -*-

module Lookout::Expectation
  class << self
    def on(expected, file, line, &block)
      expected.to_lookout_expected.to_lookout_expectation(file, line, &block)
    # TODO: Enable something like this in the future.
    # rescue
    #   Lookout::Expectations::State.new(expected, file, line, &block)
    end
  end
end
