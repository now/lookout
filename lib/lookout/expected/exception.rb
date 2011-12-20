# -*- coding: utf-8 -*-

class Lookout::Expected::Exception < Lookout::Expected::Object
  def actualize(file, line, &block)
    Lookout::Expect::Exception.new(self, file, line, &block)
  end

  # This test doesn’t quite match that that Ruby defines, as we make sure that
  # the classes are the same.
  # Lookout::Expect::StandardError makes sure of this before this method is
  # called, but it’s safer to have this test here as well, at least until we
  # figure out why Ruby doesn’t make sure of this.
  def =~(other)
    subject.equal?(other) or
      (subject.class == other.class and
       (other.respond_to? :message rescue false) and
       (m = other.message rescue nil) and
       ((r = regexp) ? r === m : subject.message == m))
  end

  def diff(other)
    return super unless subject.class == other.class and
      String === subject.message and
      not regexp and
      Exception === other and
      (other.respond_to? :message rescue false) and
      (m = other.message rescue nil)
    subject.message.to_lookout_expected.diff(m)
  end

  private

  def format(other)
    return super unless r = regexp
    '%s≠#<%s: %p>' %
      [Lookout::Inspect::Actual.new(other).call,
       subject.class,
       r]
  end

  # The first test works in Ruby 1.8.  In Ruby 1.9, however, #message always
  # returns a String, unless the conversion raises an error.  Sadly, this
  # conversion can’t keep track of the ‘e’ and ‘n’ options for encoding
  # handling.
  def regexp
    return subject.message if Regexp === subject.message
    return nil unless subject.message =~ /\A\(\?([mix]*)(-[mix]+)?:(.*)\)\z/
    Regexp.new($3,
               0 |
               ($1.include?('m') ? Regexp::MULTILINE : 0) |
               ($1.include?('i') ? Regexp::IGNORECASE : 0) |
               ($1.include?('x') ? Regexp::EXTENDED : 0))
  end
end
