# -*- coding: utf-8 -*-

# The “to receive” keywords on {::Object}s.
class Lookout::Object::To::Receive < Lookout::Aphonic
  # @param [::Object] subject The object that is expecting a method
  def initialize(subject)
    @subject = subject
  end

  private

  # @param (see Reception#initialize)
  # @return [Reception] A method reception expectation on the subject for
  #   _method_ with _args_, using _body_ as the method definition
  def method_missing(method, *args, &body)
    Lookout::Reception.new(@subject, method, *args, &body)
  end
end
