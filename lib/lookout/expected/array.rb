# -*- coding: utf-8 -*-

# Represents expected {::Array}s.
class Lookout::Expected::Array < Lookout::Expected::Object
  # @param [::Array] other
  # @return [Lookout::Difference::Array, nil] A difference report generator
  #   between _other_ and {#subject}, unless their content exhibit no
  #   {Object differences}
  def difference(other)
    Lookout::Difference::Array.new(other, subject) unless
      Array === other and
      subject.size == other.size and
      subject.enum_for(:none?).with_index{ |v, i|
        v.to_lookout_expected.difference(other[i])
      }
  end
end
