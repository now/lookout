# -*- coding: utf-8 -*-

class Lookout::Results::Fulfilled < Lookout::Result
  is :fulfilled

  def initialize(file, line)
    super file, line
  end
end
