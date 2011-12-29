# -*- coding: utf-8 -*-

module Lookout::Stub::Method
  def initialize(object, method, &body)
    @object, @method, @body = object, method.to_sym, body || Nil
  end

  def ==(other)
    self.class == other.class and
      object == other.object and
      method == other.method and
      body == other.body
  end

  protected

  attr_reader :object, :method, :body

  private

  Nil = proc{ Lookout::Stub::Object.new }

  def stash
    :"__stubbed_method_#{method}"
  end

  def meta
    Kernel == object ? object : (class << object; self; end)
  end
end
