# -*- coding: utf-8 -*-

class Lookout::Difference::Exception < Lookout::Difference::Object
  def initialize(actual, expected, regexp = nil)
    @regexp = regexp
    super actual, expected
  end

  def message
    @regexp ? '%s≉%s' % [inspect_actual, inspect_expected] : super
  end

  def diff
    return super unless @expected.class == @actual.class and
      String === @expected.message and
      not @regexp and
      (m = @actual.message rescue nil) and
      String === m
    @expected.message.to_lookout_expected.difference(m).diff
  end

  private

  def inspect_expected
    @regexp ? '#<%s: %p>' % [@expected.class, @regexp] : super
  end
end
