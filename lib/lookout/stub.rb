# -*- coding: utf-8 -*-

# Object that only responds to a given set of methods and returns itself
# whenever it receives a method call it doesn’t know anything about.
class Lookout::Stub
  class << self
    # Defines _method_ on an objects _meta_ object to _value_.  If _value_ is a
    # Proc it’ll be used as a method definition with rules that depend on if
    # whether it’s a lambda or not.  Otherwise, the method definition will be
    # set up to return _value_.
    # @param [Object] meta
    # @param [Symbol] method
    # @param [Object] value
    def define(meta, method, value)
      meta.instance_eval{
        case value
        when Proc
          if (value.lambda? rescue false)
            define_method method, value
          else
            define_method method do |*args, &block|
              value.call(*args, &block)
            end
          end
        else
          define_method method do |*|
            value
          end
        end
      }
    end
  end

  # Maps each method name key in _methods_ to its value definition.  If the
  # value of the key is a Proc it’ll be used as the method definition.
  # Otherwise, the method definition will be set up to return _value_.
  # @param [Hash<Symbol,Object>] methods
  def initialize(methods = {})
    (class << self; self; end).module_eval do
      methods.each do |name, value|
        Lookout::Stub.define self, name, value
      end
    end unless methods.empty?
  end

  def inspect; 'stub' end

  private

  # Ignores any method calls that it doesn’t know anything about.
  # @param [Symbol] method
  # @param [Object, …] args
  # @return [self]
  def method_missing(method, *args) self end
end
