# -*- coding: utf-8 -*-

class Lookout::Stub::Method::Undefined
  include Lookout::Stub::Method

  def define
    visibility = meta_exec(method){ |method|
      private_method_defined?(method) ? :private :
        protected_method_defined?(method) ? :protected :
          :public
    }
    unbound = meta_exec(method){ |method|
      begin instance_method(method); rescue NameError; nil end
    }
    meta_exec method, defined(visibility, unbound) do |method, defined|
      define_method method do |*args, &block|
        defined.call(*args, &block)
      end
      send visibility, method
      defined
    end
  end

  private

  def defined(visibility, unbound)
    Defined.new(object, method, visibility, unbound, &body)
  end
end
