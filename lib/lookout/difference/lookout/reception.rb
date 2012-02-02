# -*- coding: utf-8 -*-

class Lookout::Difference::Lookout::Reception < Lookout::Difference::Range
  def initialize(actual, expected, message)
    super actual, expected
    @message = message
  end

  def diff
    [message]
  end
end
