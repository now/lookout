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
       ((r = regexp(expected)) ? r === m : expected.message == m))
  end

  def diff(expected, actual)
    return super unless expected.class == actual.class and
      String === expected.message and
      not regexp(expected) and
      StandardError === actual and
      (actual.respond_to? :message rescue false) and
      (m = actual.message rescue nil)
    Lookout::Equality.diff(expected.message, m)
  end

  private

  def format(expected, actual)
    return super unless r = regexp(expected)
    '%s≠#<%s: %p>' %
      [Lookout::Inspect::Actual.new(actual).call,
       expected.class,
       r]
  end

  # The first test works in Ruby 1.8.  In Ruby 1.9, however, #message always
  # returns a String, unless the conversion raises an error.  Sadly, this
  # conversion can’t keep track of the ‘e’ and ‘n’ options for encoding
  # handling.
  def regexp(expected)
    return expected.message if Regexp === expected.message
    return nil unless expected.message =~ /\A\(\?([mix]*)(-[mix]+)?:(.*)\)\z/
    Regexp.new($3,
               0 |
               ($1.include?('m') ? Regexp::MULTILINE : 0) |
               ($1.include?('i') ? Regexp::IGNORECASE : 0) |
               ($1.include?('x') ? Regexp::EXTENDED : 0))
  end
end
