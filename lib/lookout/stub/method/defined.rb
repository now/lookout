# -*- coding: utf-8 -*-

class Lookout::Stub::Method::Defined
  include Lookout::Stub::Method

  def initialize(object, method, &body)
    super object, method, &body
    @definition = Definition.new(object, method){ |*args, &block|
      call(*args, &block)
    }
  end

  def ==(other)
    super and definition == other.definition
  end

  def undefine
    definition.undefine
    Undefined.new(object, method, &body)
  end

  protected

  attr_reader :definition

  private

  def call(*args, &block)
    body.call(*args, &block)
  end
end
