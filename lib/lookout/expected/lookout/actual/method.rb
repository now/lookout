# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::Actual::Method < Lookout::Expected::Object
  def difference(other)
    subject.call(other) ?
      nil :
      Lookout::Difference::Lookout::Actual::Method.new(other, subject)
  end
end
