# -*- coding: utf-8 -*-

class Lookout::Equalities::StandardError < Lookout::Equalities::Object
  Lookout::Equality.register self, StandardError

  # This test doesn’t quite match that that Ruby defines, as we make sure that
  # the classes are the same.  This isn’t strictly necessary, as
  # Lookout::Expectations::State makes sure of this before this method is
  # called, but it’s safer to have this test here as well, at least until we
  # figure out why Ruby doesn’t make sure of this.
  def equal?(expected, actual)
    expected.equal?(actual) or
      (expected.class == actual.class and
       (actual.respond_to? :message rescue false) and
       (m = actual.message rescue nil) and
       ((r = regexp(expected) and r === m) or
        expected.message == m))
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
