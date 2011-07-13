# -*- coding: utf-8 -*-

class Lookout::Equalities::Includes < Lookout::Equalities::Object
  Lookout::Equality.register self, Module, Range, Regexp

  def equal?(expected, actual)
    expected === actual or expected == actual
  end
end
