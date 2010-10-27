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
end

class Lookout::Equality::Object
  Lookout::Equality.register self, Object

  def equal?(expected, actual)
    expected == actual
  end

  def message(expected, actual)
    format = format(expected, actual)
    return format unless diff = diff(expected, actual)
    (diff.include?("\n") ? "%s\n%s" : '%s: %s') % [format, diff]
  end

  def diff(expected, actual)
  end

private

  def format(expected, actual)
    '%p≠%p' % [actual, expected]
  end
end

class Lookout::Equality::Includes < Lookout::Equality::Object
  Lookout::Equality.register self, Module, Range, Regexp

  def equal?(expected, actual)
    expected === actual or expected == actual
  end
end

class Lookout::Equality::Boolean < Lookout::Equality::Object
  Lookout::Equality.register self, TrueClass, FalseClass

  def equal?(expected, actual)
    expected == !!actual
  end
end

class Lookout::Equality::String < Lookout::Equality::Object
  Lookout::Equality.register self, String

  def diff(expected, actual)
    (expected.include? "\n" or actual.include? "\n") ?
     Lookout::Diff::Format::Unified.diff(actual.split("\n"),
                                         expected.split("\n")).to_a.join("\n") :
     Lookout::Diff::Format::Inline.diff(actual, expected)
  end
end

class Lookout::Equality::Array < Lookout::Equality::Object
  Lookout::Equality.register self, Array

  def equal?(expected, actual)
    return false unless actual.is_a? Array and expected.size == actual.size
    expected.each_with_index do |v, i|
      return false unless Lookout::Equality.equal? v, actual[i]
    end
    true
  end
end

class Lookout::Equality::Hash < Lookout::Equality::Object
  Lookout::Equality.register self, Hash

  def equal?(expected, actual)
    return false unless other.is_a? Hash and expected.size == actual.size
    expected.all?{ |k, v| Lookout::Equality.equal? v, actual[k] }
  end
end

class Lookout::Equality::StandardError < Lookout::Equality::Object
  Lookout::Equality.register self, ::StandardError

  def equal?(expected, actual)
    expected.equal?(actual) or
      (actual.respond_to? :message and
       ((expected.message.is_a? Regexp and expected.message === actual.message) or
        expected.message == actual.message))
  end

  def diff(expected, actual)
    return super unless expected.message.is_a? String and
      actual.is_a? StandardError and actual.respond_to? :message
    Lookout::Equality.diff(expected.message, actual.message)
  end

private

  def format(expected, actual)
    expected.message.is_a?(Regexp) ?
      '%p≠#<%s: %p>' % [actual, expected.class, expected.message] :
      super
  end
end