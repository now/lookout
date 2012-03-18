# -*- coding: utf-8 -*-

class Lookout::Expected::Array < Lookout::Expected::Object
  def difference(other)
    Lookout::Difference::Array.new(other, subject) unless
      Array === other and
      subject.size == other.size and
      subject.enum_for(:none?).with_index{ |v, i|
        v.to_lookout_expected.difference(other[i])
      }
  end
end
