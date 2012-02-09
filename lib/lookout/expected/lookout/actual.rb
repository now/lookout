# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::Actual < Lookout::Expected::Object
  def difference(other)
    subject.call(other) ?
      nil :
      Lookout::Difference::Lookout::Actual.new(other, subject)
  end
end
