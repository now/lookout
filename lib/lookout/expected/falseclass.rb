# -*- coding: utf-8 -*-

class Lookout::Expected::FalseClass < Lookout::Expected::Object
  def difference(other)
    super((not not other))
  end
end
