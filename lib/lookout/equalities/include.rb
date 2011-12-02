# -*- coding: utf-8 -*-

class Lookout::Equalities::Includes < Lookout::Equalities::Object
  Lookout::Equality.register self, Module, Range, Regexp

  # TODO: Should we perhaps reverse these tests to have the more specific one
  # first?
  def equal?(expected, actual)
    expected === actual or expected == actual
  end
end
