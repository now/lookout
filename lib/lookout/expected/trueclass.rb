# -*- coding: utf-8 -*-

class Lookout::Expected::TrueClass < Lookout::Expected::Object
  def =~(other)
    not not other
  end
end
