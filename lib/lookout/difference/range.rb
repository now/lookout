# -*- coding: utf-8 -*-

class Lookout::Difference::Range < Lookout::Difference::Object
  def message
    '%s%s%s' % [inspect_actual, ::Range === actual ? '≠' : '∉', inspect_expected]
  end
end
