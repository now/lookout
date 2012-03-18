# -*- coding: utf-8 -*-

class Lookout::Expected::Hash < Lookout::Expected::Object
  def difference(other)
    Lookout::Difference::Hash.new(other, subject) unless
      Hash === other and
      subject.size == other.size and
      subject.none?{ |k, v| v.to_lookout_expected.difference(other[k]) }
  end
end
