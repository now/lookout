# -*- coding: utf-8 -*-

class Lookout::Stub::Object
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
          define_method name do
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

  def method_missing(method, *args)
    self
  end
end
