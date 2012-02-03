# -*- coding: utf-8 -*-

class Lookout::Expected::String < Lookout::Expected::Object
  def difference(other)
    subject == other ? nil : Lookout::Difference::String.new(other, subject)
  end
end
