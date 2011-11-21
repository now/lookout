# -*- coding: utf-8 -*-

class Lookout::Inspect::Actual < Lookout::Inspect
  def initialize(actual)
    super actual, 'actual result'
  end
end
