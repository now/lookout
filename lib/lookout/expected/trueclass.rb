# -*- coding: utf-8 -*-

class Lookout::Expected::TrueClass < Lookout::Expected::Object
  def difference(other)
    super((not not other))
  end
end
