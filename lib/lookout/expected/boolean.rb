# -*- coding: utf-8 -*-

class Lookout::Expected::Boolean < Lookout::Expected::Object
  def =~(other)
    @expected ?
      nil != other && false != other :
      nil == other || false == other
  end
end
