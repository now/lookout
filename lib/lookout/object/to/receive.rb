# -*- coding: utf-8 -*-

# The “to receive” keywords on {::Object}s.
class Lookout::Object::To::Receive < Lookout::Aphonic
  # Stands in for _object_, allowing a {Reception} exception that expects the
  # given method to be called to be set up.
  # @param [::Object] object
  def initialize(object)
    @object = object
  end

  private

  # @param (see Reception#initialize)
  # @return [Reception] A method reception expectation on the subject for
  #   _method_ with _args_, using _body_ as the method definition
  def method_missing(method, *args, &body)
    Lookout::Reception.new(@object, method, *args, &body)
  end
end
