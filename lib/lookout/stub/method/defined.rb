# -*- coding: utf-8 -*-

class Lookout::Stub::Method::Defined
  include Lookout::Stub::Method

  def initialize(object, method, visibility, unbound, &body)
    super object, method, &body
    @visibility, @unbound = visibility, unbound
  end

  def ==(other)
    super and
      visibility == other.visibility and
      unbound == other.unbound
  end

  def call(*args, &block)
    body.call(*args, &block)
  end

  def undefine
    meta_exec method, visibility, unbound do |method, visibility, unbound|
      remove_method method
      if unbound
        define_method method, unbound
        send visibility, method
      end
    end
    undefined
  end

  protected

  attr_reader :visibility, :unbound

  private

  def undefined
    Undefined.new(object, method, &body)
  end
end
