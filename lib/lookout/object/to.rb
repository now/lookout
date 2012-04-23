# -*- coding: utf-8 -*-

# The “to” keyword on {::Object}s.
class Lookout::Object::To
  # Wraps _object_ as a “to”.
  # @param [::Object] object
  def initialize(object)
    @object = object
  end

  # @return [Object::To::Receive] A wrapper around the object that’ll set up a
  #   reception expectation on it
  def receive
    Lookout::Object::To::Receive.new(@object)
  end
end
