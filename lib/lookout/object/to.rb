# -*- coding: utf-8 -*-

# The “to” keyword on {::Object}s.
class Lookout::Object::To < Lookout::Aphonic
  # @param [::Object] subject The object to wrap
  def initialize(subject)
    @subject = subject
  end

  # @return [Lookout::Object::To::Receive] A wrapper around the object that’ll
  #   set up a reception expectation on it
  def receive
    Lookout::Object::To::Receive.new(@subject)
  end
end
