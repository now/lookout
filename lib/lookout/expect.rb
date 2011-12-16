# -*- coding: utf-8 -*-

module Lookout::Expect
  class << self
    def on(expected, file, line, &block)
      expected.to_lookout_expected.actualize(file, line, &block)
    # TODO: Enable something like this in the future.
    # rescue
    #   Lookout::Expectations::State.new(expected, file, line, &block)
    end
  end
end
