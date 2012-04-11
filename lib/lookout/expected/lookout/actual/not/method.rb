# -*- coding: utf-8 -*-

# Represents expected {::Lookout::Actual::Not::Method}s.
class Lookout::Expected::Lookout::Actual::Not::Method < Lookout::Expected::Object
  # @param [::Object] other
  # @return [Lookout::Difference::Lookout::Actual::Not::Method, nil] A
  #   difference report generator between _other_ and {#subject}, unless
  #   invoking {#subject} on _other_ returns false
  def difference(other)
    Lookout::Difference::Lookout::Actual::Not::Method.new(other, subject) if
      subject.call(other)
  end
end
