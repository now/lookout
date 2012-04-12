# -*- coding: utf-8 -*-

# Stub method collection.  Keeps track of defined stub methods so that they may
# later be undefined properly.
class Lookout::Stub::Methods
  def initialize
    @methods = []
  end

  # Defines _method_ on _object_, using _body_ as the method definition.
  # @param (see Method#initialize)
  # @return [self]
  def define(object, method, &body)
    @methods << Lookout::Stub::Method::Undefined.new(object, method, &body).define
    self
  end

  # Undefines all defined stub methods.
  # @return [self]
  def undefine
    @methods.each(&:undefine)
    self
  end
end
