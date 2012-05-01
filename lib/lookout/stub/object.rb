# -*- coding: utf-8 -*-

# Object that only responds to a given set of methods and returns itself
# whenever it receives a method call it doesn’t know anything about.
class Lookout::Stub::Object
  # Maps each method name (Symbol) key in _methods_ to its value definition.
  # If the value of the key is a Proc it’ll be used as the method definition.
  # Otherwise, the method definition will be set up to return the value.
  # @param [Hash<Symbol,Object>] methods
  def initialize(methods = {})
    (class << self; self; end).module_eval do
      methods.each do |name, value|
        case value
        when Proc
          if (value.lambda? rescue false)
            define_method name, value
          else
            define_method name do |*args, &block|
              value.call(*args, &block)
            end
          end
        else
          define_method name do |*|
            value
          end
        end
      end
    end unless methods.empty?
  end

  def inspect
    'stub'
  end

  private

  # Ignores any method calls that it doesn’t know anything about.
  # @param [Symbol] method
  # @param [Object, …] args
  # @return [self]
  def method_missing(method, *args)
    self
  end
end
