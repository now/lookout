# -*- coding: utf-8 -*-

class Lookout::Stub::Method::Undefined
  include Lookout::Stub::Method

  def define
    meta_exec method, stash, defined do |method, stash, defined|
      visibility = private_method_defined?(method) ? :private :
        protected_method_defined?(method) ? :protected :
        :public
      alias_method stash, method if
        method_defined? method or private_method_defined? method
      define_method method do |*args, &block|
        defined.call(*args, &block)
      end
      send visibility, method
      defined
    end
  end

  private

  def defined
    Defined.new(object, method, &body)
  end
end
