# -*- coding: utf-8 -*-

# Represents expected {::Lookout::Reception}s.  This is used to check mock
# method invocation counts.
class Lookout::Expected::Lookout::Reception < Lookout::Expected::Object
  # @param [::Object] subject The test subject (expected value)
  # @param [Symbol] method The name of the method to mock
  # @param [Object, …] *args The arguments that the mock method is
  #   expected to receive
  # @param [Proc] &body The mock method’s body
  def initialize(subject, method, calls, *args, &body)
    super subject
    @method, @calls, @args, @body = method, calls, args, body
  end

  # @param (see Object#expect)
  # @yieldparam (see Object#expect)
  # @yieldreturn (see Object#expect)
  # @return [Lookout::Expect::Lookout::Reception] An expect block for the
  #   receiver
  def expect(file, line, &block)
    Lookout::Expect::Lookout::Reception.new(self, file, line, &block)
  end

  # @param [Proc] other
  # @return [Lookout::Difference::Lookout::Reception, nil] A difference report
  #   generator between the actual number of times the method was received and
  #   the range of expected number of receptions, unless _other_, when called,
  #   makes the earlier lay within the latter
  def difference(other)
    Lookout::Mock::Methods.during do |methods|
      methods.define(subject, @method, @calls, *@args, &@body)
      other.call
    end
    nil
  rescue Lookout::Mock::Method::Calls::TooFewError => e
    Lookout::Difference::Lookout::Reception.new(e.calls, e.range, e.message)
  end
end
