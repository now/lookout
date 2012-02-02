# -*- coding: utf-8 -*-

class Lookout::Expected::Array < Lookout::Expected::Object
  def =~(other)
    return false unless Array === other and subject.size == other.size
    subject.each_with_index do |v, i|
      return false unless v.to_lookout_expected =~ other[i]
    end
    true
  end

  def difference(other)
    self =~ other ? nil : Lookout::Difference::Array.new(other, subject)
  end
end
