# -*- coding: utf-8 -*-

class Lookout::Expected::Range < Lookout::Expected::Object
  def difference(other)
    (subject === other or subject == other) ?
      nil :
      Lookout::Difference::Range.new(other, subject)
  end
end
