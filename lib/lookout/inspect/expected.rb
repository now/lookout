# -*- coding: utf-8 -*-

# Non-failing inspection of {Lookout::Expected expected values}.
class Lookout::Inspect::Expected < Lookout::Inspect
  # @param [Object] expected The expected value to inspect
  def initialize(expected)
    super expected, 'expected value'
  end
end
