# -*- coding: utf-8 -*-

# Mock method that hasn’t been defined on its object yet.  Base state of a mock
# method.  May be {#define}d, in which case it turns into a {Defined} mock
# method.
class Lookout::Mock::Method::Undefined < Lookout::Stub::Method::Undefined
  include Lookout::Mock::Method

  # @return [Defined] The defined version of this mock method
  def define; Defined.new(object, method, calls, *args, &body) end
end
