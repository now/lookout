# -*- coding: utf-8 -*-

class Lookout::Expected::String < Lookout::Expected::Object
  def difference(other)
    Lookout::Difference::String.new(other, subject) unless subject == other
  end
end
