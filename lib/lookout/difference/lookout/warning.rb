# -*- coding: utf-8 -*-

class Lookout::Difference::Lookout::Warning < Lookout::Difference::Lookout::Output
  def message
    '%s≉%s' % [inspect_actual, inspect_expected]
  end
end
