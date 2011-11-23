# -*- coding: utf-8 -*-

class Lookout::Equalities::Boolean < Lookout::Equalities::Object
  Lookout::Equality.register self, TrueClass, FalseClass

  def equal?(expected, actual)
    expected ?
      nil != actual && false != actual :
      nil == actual || false == actual
  end
end
