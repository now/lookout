# -*- coding: utf-8 -*-

# The “to receive” keywords on {::Object}s.
class Lookout::Object::To::Receive < Lookout::Aphonic
  # Stands in for OBJECT, allowing a {Reception} exception that expects the
  # given method to be called to be set up.
  # @param [::Object] object
  def initialize(object) @object = object end

  private

  # @param (see Reception#initialize)
  # @return [Reception] A method reception expectation on the subject for
  #   METHOD with _args_, using _body_ as the method definition
  def method_missing(method, *args, &body)
    Lookout::Reception.of(@object, method, *args, &body)
  end
end
