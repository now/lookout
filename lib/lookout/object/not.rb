# -*- coding: utf-8 -*-

# The “not” keyword on {::Object}s.
class Lookout::Object::Not < Lookout::Aphonic
  # @param [::Object] subject The object to wrap
  def initialize(subject)
    @subject = subject
  end

  # Method for improving readability of “not” keyword set-up.
  # @return [self]
  def to
    self
  end

  # @return [Lookout::Object::To::Receive] A wrapper around the object that’ll
  #   set up a reception expectation on it
  def receive
    Lookout::Object::Not::Receive.new(@subject)
  end
end
