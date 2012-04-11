# -*- coding: utf-8 -*-

# Represents expected {::Lookout::Actual::Method}s.
class Lookout::Expected::Lookout::Actual::Method < Lookout::Expected::Object
  # @param [::Object] other
  # @return [Lookout::Difference::Lookout::Actual::Method, nil] A difference
  #   report generator between _other_ and {#subject}, unless invoking
  #   {#subject} on _other_ returns true
  def difference(other)
    Lookout::Difference::Lookout::Actual::Method.new(other, subject) unless
      subject.call(other)
  end
end
