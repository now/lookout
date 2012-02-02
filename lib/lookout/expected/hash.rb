# -*- coding: utf-8 -*-

class Lookout::Expected::Hash < Lookout::Expected::Object
  def =~(other)
    return false unless Hash === other and subject.size == other.size
    subject.all?{ |key, value| value.to_lookout_expected =~ other[key] }
  end

  def difference(other)
    self =~ other ? nil : Lookout::Difference::Hash.new(other, subject)
  end
end
