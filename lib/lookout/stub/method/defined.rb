# -*- coding: utf-8 -*-

class Lookout::Stub::Method::Defined
  include Lookout::Stub::Method

  def call(*args, &block)
    body.call(*args, &block)
  end

  def undefine
    meta.module_exec(method, stash) do |method, stash|
      remove_method method
      if method_defined? stash or private_method_defined? stash
        alias_method method, stash
        remove_method stash
      end
    end
    undefined
  end

  private

  def undefined
    Undefined.new(object, method, &body)
  end
end
