# -*- coding: utf-8 -*-

class Lookout::Equalities::StandardError < Lookout::Equalities::Object
  Lookout::Equality.register self, ::StandardError

  def equal?(expected, actual)
    expected.equal?(actual) or
      ((actual.respond_to? :message rescue false) and
       ((Regexp === expected.message and expected.message === actual.message) or
        expected.message == actual.message))
  end

  def diff(expected, actual)
    return super unless String === expected.message and
      StandardError === actual and (actual.respond_to? :message rescue false)
    Lookout::Equality.diff(expected.message, actual.message)
  end

private

  def format(expected, actual)
    Regexp === expected.message ?
      '%p≠#<%s: %p>' % [actual, expected.class, expected.message] :
      super
  end
end
