# -*- coding: utf-8 -*-

class Lookout::Difference::Module < Lookout::Difference::Object
  def message
    '%s%s%s' % [inspect_actual, Module === @actual ? '≠' : '≉', inspect_expected]
  end
end
