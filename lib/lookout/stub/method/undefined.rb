# -*- coding: utf-8 -*-

class Lookout::Stub::Method::Undefined
  include Lookout::Stub::Method

  def define
    meta.module_exec(method, visibility, stash, defined) do |method, visibility, stash, defined|
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

  def visibility
    meta.private_method_defined?(method) ? :private :
      meta.protected_method_defined?(method) ? :protected :
        :public
  end

  def defined
    Defined.new(object, method, &body)
  end
end
