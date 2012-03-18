# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::Actual::Method < Lookout::Expected::Object
  def difference(other)
    Lookout::Difference::Lookout::Actual::Method.new(other, subject) unless
      subject.call(other)
  end
end
