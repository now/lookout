# -*- coding: utf-8 -*-

class Lookout::Difference::Regexp < Lookout::Difference::Object
  def symbol
    Regexp === actual ? '≠' : '≉'
  end
end
