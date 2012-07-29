# -*- coding: utf-8 -*-

# Non-failing inspection of {Lookout::Expected expected values}.
class Lookout::Inspect::Expected < Lookout::Inspect
  # Non-failing inspection of an _expected_ value
  # @param [Object] expected
  def initialize(expected) super expected, 'expected value' end
end
