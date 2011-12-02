# -*- coding: utf-8 -*-

class Lookout::Equalities::Output < Lookout::Equalities::Includes
  Lookout::Equality.register self, Lookout::Output

  def diff(expected, actual)
    expected.diff(actual)
  end
end
