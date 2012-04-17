# -*- coding: utf-8 -*-

# Base module for stub methods.
module Lookout::Stub::Method
  # Prepares the stub _method_ on _object_, using _body_ as the method
  # definition.
  # @param [Object] object
  # @param [Symbol] method
  # @param [Proc] &body
  def initialize(object, method, &body)
    @object, @method, @body = object, method.to_sym, body || Nil
  end

  # @param [Method] other
  # @return [Boolean] True if the receiver’s class, object, method, and body
  #   `#==` those of _other_
  def ==(other)
    self.class == other.class and
      object == other.object and method == other.method and body == other.body
  end

  alias eql? ==

  def hash
    [object, method, body].hash
  end

  # @return [String] A String representation of the object and method
  def to_s
    '%s%s%s' % [Lookout::Inspect.new(object, 'object').call,
                Class === object ? '.' : '#',
                method]
  end

  protected

  attr_reader :object, :method, :body

  private

  Nil = proc{ Lookout::Stub::Object.new }
end
