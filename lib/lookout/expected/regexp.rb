# -*- coding: utf-8 -*-

class Lookout::Expected::Regexp < Lookout::Expected::Object
  def difference(other)
    (subject === other or subject == other) ?
      nil :
      Lookout::Difference::Regexp.new(other, subject)
  end
end
