# -*- coding: utf-8 -*-

# Represents expected {::Lookout::Reception}s.  This is used to check mock
# method invocation counts.
class Lookout::Expected::Lookout::Reception < Lookout::Expected::Object
  # Expects _object_ to receive _method_ _calls_ number of times with _args_,
  # using _body_ as the method definition.
  # @param (see Mock::Method#initialize)
  def initialize(object, method, calls, *args, &body)
    super object
    @method, @calls, @args, @body = method, calls, args, body
  end

  # @param (see Object#expect)
  # @yieldparam (see Object#expect)
  # @yieldreturn (see Object#expect)
  # @return [Expect::Lookout::Reception] An expect block for the receiver at
  #   _line_ in _file_ that’ll yield the {#expected} object and expect the
  #   block to call the method the appropriate number of times
  def expect(file, line, &block)
    Lookout::Expect::Lookout::Reception.new(self, file, line, &block)
  end

  # @param [Proc] actual
  # @return [Difference::Lookout::Reception, nil] A difference report between
  #   the actual number of times the method was received and the range of
  #   expected number of receptions unless _actual_, when called, makes the
  #   earlier lay within the latter
  def difference(actual)
    Lookout::Mock::Methods.during do |methods|
      methods.define(expected, @method, @calls, *@args, &@body)
      actual.call
    end
    nil
  rescue Lookout::Mock::Method::Calls::TooFewError => e
    Lookout::Difference::Lookout::Reception.new(e.calls, e.range, e.message)
  end
end
