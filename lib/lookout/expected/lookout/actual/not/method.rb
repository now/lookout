# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::Actual::Not::Method < Lookout::Expected::Object
  def difference(other)
    Lookout::Difference::Lookout::Actual::Not::Method.new(other, subject) if
      subject.call(other)
  end
end
