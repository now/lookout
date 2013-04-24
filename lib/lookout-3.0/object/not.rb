# -*- coding: utf-8 -*-

# The “not” keyword on {::Object}s.
class Lookout::Object::Not
  # Wraps OBJECT as a “not”.
  # @param [::Object] object
  def initialize(object) @object = object end

  # Method for improving readability of “not” keyword set-up.
  # @return [self]
  def to; self end

  # @return [Receive] A wrapper around the object that’ll set up a reception
  #   expectation on it
  def receive; Receive.new(@object) end
end
