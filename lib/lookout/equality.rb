# -*- coding: utf-8 -*-

module Lookout::Equality
  class << self
    def register(equality, *types)
      eq = equality.new
      types.each do |type|
        equalities[type] = eq
      end
    end

    def equal?(expected, actual)
      self[expected].equal? expected, actual
    end

    def message(expected, actual)
      self[expected].message expected, actual
    end

    def diff(expected, actual)
      self[expected].diff expected, actual
    end

  private

    def [](expected)
      equalities[expected.class.ancestors.find{ |type| equalities[type] }]
    end

    def equalities
      @equalities ||= {}
    end
  end

  require 'lookout/equalities'
end
