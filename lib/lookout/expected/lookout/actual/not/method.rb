# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::Actual::Not::Method < Lookout::Expected::Object
  def difference(other)
    subject.call(other) ?
      Lookout::Difference::Lookout::Actual::Not::Method.new(other, subject) :
      nil
  end
end
