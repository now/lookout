# -*- coding: utf-8 -*-

class Lookout::Expected::Hash < Lookout::Expected::Object
  def difference(other)
    (Hash === other and
     subject.size == other.size and
     subject.none?{ |k, v| v.to_lookout_expected.difference(other[k]) }) ?
      nil :
      Lookout::Difference::Hash.new(other, subject)
  end
end
