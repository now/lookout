# -*- coding: utf-8 -*-

module Lookout::Stub::Method
  def initialize(object, method, &body)
    @object, @method, @body = object, method.to_sym, body || Nil
  end

  private

  Nil = proc{ Lookout::Stub::Object.new }

  def stash
    :"__stubbed_method_#{@method}"
  end

  def meta
    Kernel == @object ? @object : (class << @object; self; end)
  end
end
