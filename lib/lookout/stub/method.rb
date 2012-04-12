# -*- coding: utf-8 -*-

# Base module for stub methods.
module Lookout::Stub::Method
  # @param [Object] object The object that _method_ will be applied to
  # @param [Symbol] method The method name
  # @param [Proc] &body The block to use as a method definition
  def initialize(object, method, &body)
    @object, @method, @body = object, method.to_sym, body || Nil
  end

  # @param [Lookout::Stub::Method] other
  # @return [Boolean] True if the receiver’s class, object, method, and body
  #   `#==` those of _other_
  def ==(other)
    self.class == other.class and
      object == other.object and
      method == other.method and
      body == other.body
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
