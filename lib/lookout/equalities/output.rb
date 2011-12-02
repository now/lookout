# -*- coding: utf-8 -*-

class Lookout::Equalities::Output < Lookout::Equalities::Include
  Lookout::Equality.register self, Lookout::Output

  def diff(expected, actual)
    expected.diff(actual)
  end
end
