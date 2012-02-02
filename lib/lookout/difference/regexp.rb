# -*- coding: utf-8 -*-

class Lookout::Difference::Regexp < Lookout::Difference::Object
  def message
    '%s%s%s' % [inspect_actual, Regexp === @actual ? '≠' : '≉', inspect_expected]
  end
end
