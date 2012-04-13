# -*- coding: utf-8 -*-

# The “not to receive” keywords on {::Object}s.
class Lookout::Object::Not::Receive < Lookout::Aphonic
  # @param [::Object] subject The object that isn’t expecting a method
  def initialize(subject)
    @subject = subject
  end

  private

  # @param (see Reception#initialize)
  # @return [Reception] A method reception expectation on the subject that expects
  #   _method_ {Reception#never never} to be called
  def method_missing(method, *args, &body)
    Lookout::Reception.new(@subject, method, *args, &body).never
  end
end
