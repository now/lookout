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
    value.extend @literals[type] if type
    value
  end
end

Lookout::Literals.register Module.new{
  def ==(other)
    self === other or super
  end
}, Module, Range, Regexp

Lookout::Literals.register Module.new {
  def ==(other)
    super(!!other)
  end
}, TrueClass, FalseClass
