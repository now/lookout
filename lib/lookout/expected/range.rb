# -*- coding: utf-8 -*-

class Lookout::Expected::Range < Lookout::Expected::Object
  def difference(other)
    Lookout::Difference::Range.new(other, subject) unless
      subject == other or
      subject === other
  end
end
