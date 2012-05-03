# -*- coding: utf-8 -*-

# Base module for stub methods.
module Lookout::Stub::Method
  # Prepares the stub _method_ on _object_, using _body_ as the method
  # definition.
  # @param [Object] object
  # @param [Symbol] method
  # @param [Proc] body
  Value(:object, :method, :'&body')
  def initialize(object, method, &body)
    super object, method.to_sym, &(body or Nil)
  end

  # @return A String representation of the object and method
  def to_s
    '%s%s%s' % [Lookout::Inspect.new(object, 'object'),
                Class === object ? '.' : '#',
                method]
  end

  private

  Nil = proc{ Lookout::Stub::Object.new }
end
