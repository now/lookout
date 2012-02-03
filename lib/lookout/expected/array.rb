# -*- coding: utf-8 -*-

class Lookout::Expected::Array < Lookout::Expected::Object
  def difference(other)
    (Array === other and
     subject.size == other.size and
     subject.enum_for(:none?).with_index{ |v, i| v.to_lookout_expected.difference(other[i]) }) ?
      nil :
      Lookout::Difference::Array.new(other, subject)
  end
end
