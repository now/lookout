# -*- coding: utf-8 -*-

class Lookout::Difference::Module < Lookout::Difference::Object
  def symbol
    Module === @actual ? '≠' : '≉'
  end
end
