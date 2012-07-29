# -*- coding: utf-8 -*-

# Non-failing inspection of actual results of {Lookout::Expect expect
# blocks}.
class Lookout::Inspect::Actual < Lookout::Inspect
  # Non-failing inspection of an _actual_ result.
  # @param [Object] actual
  def initialize(actual) super actual, 'actual result' end
end
