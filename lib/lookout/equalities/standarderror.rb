# -*- coding: utf-8 -*-

class Lookout::Equalities::StandardError < Lookout::Equalities::Object
  Lookout::Equality.register self, ::StandardError

  def equal?(expected, actual)
    expected.equal?(actual) or
      ((actual.respond_to? :message rescue false) and
       ((regexp(expected) and regexp(expected) === actual.message) or
        expected.message == actual.message))
  end

  def diff(expected, actual)
    return super unless String === expected.message and
      StandardError === actual and (actual.respond_to? :message rescue false)
    Lookout::Equality.diff(expected.message, actual.message)
  end

private

  def format(expected, actual)
    regexp(expected) ?
      '%p≠#<%s: %p>' % [actual, expected.class, regexp(expected)] :
      super
  end

  def regexp(expected)
    return expected.message if Regexp === expected.message
    return Regexp.new(expected.message) if expected.message =~ /\A\(\?-[mix]+:.*\)\z/
    nil
  end
end
