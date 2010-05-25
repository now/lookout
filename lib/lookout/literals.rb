# -*- coding: utf-8 -*-

module Lookout::Literals
  def self.register(literal, *types)
    @literals ||= {}
    types.each do |type|
      @literals[type] = literal
    end
  end

  def self.equalify(value)
    type = value.class.ancestors.find{ |type| @literals[type] }
    return @literals[type].new(value) if type
    value
  end
end

module Lookout::Literal
  def initialize(value)
    @value = value
  end

  def inspect
    @value.inspect
  end

  def to_s
    @value.to_s
  end

  def method_missing(method, *args, &block)
    @value.send(method, *args, &block)
  end
end

Lookout::Literals.register Class.new{
  include Lookout::Literal

  def eql?(other)
    @value.eql? other
  end

  def ==(other)
    @value === other || @value == other
  end
}, Module, Range, Regexp

Lookout::Literals.register Class.new{
  include Lookout::Literal

  def ==(other)
    @value == !!other
  end
}, TrueClass, FalseClass

Lookout::Literals.register Class.new{
  include Lookout::Literal

  def ==(other)
    return false unless other.is_a? Array and @value.size == other.size
    @value.each_with_index do |v, i|
      return false unless Lookout::Literals.equalify(v) == other[i]
    end
    true
  end
}, Array

Lookout::Literals.register Class.new{
  include Lookout::Literal

  def ==(other)
    return false unless other.is_a? Hash and @value.size == other.size
    @value.all?{ |k, v| Lookout::Literals.equalify(v) == other[k] }
  end
}, Hash
