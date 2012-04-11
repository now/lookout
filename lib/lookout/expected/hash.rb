# -*- coding: utf-8 -*-

# Represents expected {::Hash}es.
class Lookout::Expected::Hash < Lookout::Expected::Object
  # @param [::Hash] other
  # @return [Lookout::Difference::Hash, nil] A difference report generator
  #   between _other_ and {#subject}, unless their content exhibit no
  #   {Object differences}
  def difference(other)
    Lookout::Difference::Hash.new(other, subject) unless
      Hash === other and
      subject.size == other.size and
      subject.none?{ |k, v| v.to_lookout_expected.difference(other[k]) }
  end
end
