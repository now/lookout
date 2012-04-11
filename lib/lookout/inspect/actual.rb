# -*- coding: utf-8 -*-

# Non-failing inspection of actual results of {Lookout::Expect expect
# blocks}.
class Lookout::Inspect::Actual < Lookout::Inspect
  # @param [Object] actual The actual result to inspect
  def initialize(actual)
    super actual, 'actual result'
  end
end
