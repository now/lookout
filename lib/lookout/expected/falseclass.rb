# -*- coding: utf-8 -*-

class Lookout::Expected::FalseClass < Lookout::Expected::Object
  def =~(other)
    not other
  end
end
