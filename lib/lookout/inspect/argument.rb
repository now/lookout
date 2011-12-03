# -*- coding: utf-8 -*-

class Lookout::Inspect::Argument < Lookout::Inspect
  def initialize(argument)
    super argument, 'argument'
  end
end
