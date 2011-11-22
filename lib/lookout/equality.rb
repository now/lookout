# -*- coding: utf-8 -*-

module Lookout::Equality
  @equalities = {}

  class << self
    def register(equality, *types)
      eq = equality.new
      types.each do |type|
        @equalities[type] = eq
      end
    end

    def equal?(expected, actual)
      self[expected].equal? expected, actual
    rescue => e
      raise e, 'cannot determine equality relationship between %s and %s: %s' %
        [Lookout::Inspect::Actual.new(actual).call,
         Lookout::Inspect::Expected.new(expected).call,
         e.message]
    end

    def message(expected, actual)
      self[expected].message expected, actual
    rescue => e
      '%s (cannot generate more specific failure message: %s)' %
        [Lookout::Equalities::Object.new.message(expected, actual), e.message]
    end

    def diff(expected, actual)
      self[expected].diff expected, actual
    rescue => e
      '(cannot diff expected value and actual result: %s)' % e.message
    end

  private

    def [](expected)
      @equalities[find(expected)]
    rescue => e
      raise e, 'cannot determine equality handler for %s: %s' %
        [Lookout::Inspect::Expected.new(expected).call, e.message]
    end

    def find(expected)
      ancestors = ancestors(klass(expected))
      begin
        # TODO: Should we raise an error if ancestors.find returns nil?
        ancestors.find{ |type| @equalities[type] } or Object
      rescue => e
        raise RuntimeError,
          '#find on #ancestors on #class failed: %s' % Lookout::Inspect::Error.new(e).call
      end
    end

    def klass(expected)
      expected.class
    rescue => e
      raise RuntimeError,
        '%s#class failed: %s' %
          [Lookout::Inspect::Expected.new(expected).call,
           Lookout::Inspect::Error.new(e).call]
    end

    def ancestors(klass)
      begin
        ancestors = klass.ancestors
      rescue => e
        raise RuntimeError,
          '#ancestors on #class failed: %s' % Lookout::Inspect::Error.new(e).call
      end
      Enumerable === ancestors or
        raise RuntimeError, '#ancestors on #class is not Enumerable'
      ancestors
    end
  end
end
