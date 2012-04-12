# -*- coding: utf-8 -*-

# A mock method that hasn’t been defined on its object yet.  This is the base
# state of a mock method.  It may be {#define}d, in which case it turns into a
# {Defined} mock method.
class Lookout::Mock::Method::Undefined < Lookout::Stub::Method::Undefined
  include Lookout::Mock::Method

  # @return [Defined] The defined version of this mock method
  def define
    Defined.new(object, method, calls, *args, &body)
  end
end
