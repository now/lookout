# -*- coding: utf-8 -*-

# The “not to receive” keywords on {::Object}s.
class Lookout::Object::Not::Receive < Lookout::Aphonic
  # Stands in for OBJECT, allowing a {Reception} exception that expects the
  # given method never to be called to be set up.
  # @param [::Object] object
  def initialize(object) @object = object end

  private

  # @param (see Reception#initialize)
  # @return [Reception] A method reception expectation on the object that
  #   expects METHOD {Reception#never never} to be called
  def method_missing(method, *args, &body)
    Lookout::Reception.of(@object, method, *args, &body).never
  end
end
