# -*- coding: utf-8 -*-

# The “not” keyword on {::Object}s.
class Lookout::Object::Not
  # Wraps _object_ as a “not”.
  # @param [::Object] object
  def initialize(object)
    @object = object
  end

  # Method for improving readability of “not” keyword set-up.
  # @return [self]
  def to
    self
  end

  # @return [Object::To::Receive] A wrapper around the object that’ll set up a
  #   reception expectation on it
  def receive
    Lookout::Object::Not::Receive.new(@object)
  end
end
