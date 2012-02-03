# -*- coding: utf-8 -*-

class Lookout::Difference::Range < Lookout::Difference::Object
  def symbol
    Range === @actual ? '≠' : '∉'
  end
end
