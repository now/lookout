# -*- coding: utf-8 -*-

# A stub method that hasn’t been defined on its object yet.  This is the base
# state of a stub method.  It may be {#define}d, in which case it turns into a
# {Defined} stub method.
class Lookout::Stub::Method::Undefined
  include Lookout::Stub::Method

  # @return [Defined] The defined version of this stub method
  def define
    Defined.new(object, method, &body)
  end
end
