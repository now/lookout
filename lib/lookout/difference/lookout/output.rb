# -*- coding: utf-8 -*-

class Lookout::Difference::Lookout::Output < Lookout::Difference::Object
  def diff
    expected.diff(actual)
  end
end
