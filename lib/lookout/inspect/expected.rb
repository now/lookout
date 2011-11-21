# -*- coding: utf-8 -*-

class Lookout::Inspect::Expected < Lookout::Inspect
  def initialize(expected)
    super expected, 'expected value'
  end
end
