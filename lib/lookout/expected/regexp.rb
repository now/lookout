# -*- coding: utf-8 -*-

class Lookout::Expected::Regexp < Lookout::Expected::Object
  def difference(other)
    Lookout::Difference::Regexp.new(other, subject) unless
      subject == other or
      subject === other
  end
end
