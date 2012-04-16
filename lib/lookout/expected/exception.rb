# -*- coding: utf-8 -*-

# Represents expected {::Exception}s.
class Lookout::Expected::Exception < Lookout::Expected::Object
  # @param (see Object#expect)
  # @yieldparam [::Exception] exception
  # @yieldreturn [::Exception]
  # @return [Expect::Exception] An expect block for the receiver at
  #   _line_ in _file_ that’ll yield the expected _exception_ and expect the
  #   exception to be raised
  def expect(file, line, &block)
    Lookout::Expect::Exception.new(self, file, line, &block)
  end

  # @param [::Exception] actual
  # @return [Difference::Exception, nil] A difference report between _actual_
  #   and {#expected} unless they’re #equal? or their classes are `#==` and
  #   their messages match or {#expected}s message is a Regexp that matches
  #   actual’s message
  def difference(actual)
    Lookout::Difference::Exception.new(actual, expected, regexp) unless
      expected.equal?(actual) or
      (expected.class == actual.class and
       (actual.respond_to? :message rescue false) and
       (m = actual.message rescue nil) and
       (regexp ? regexp === m : expected.message == m))
  end

  private

  # The first test works in Ruby 1.8.  In Ruby 1.9, however, #message always
  # returns a String, unless the conversion raises an error.  Sadly, this
  # conversion can’t keep track of the ‘e’ and ‘n’ options for encoding
  # handling.
  # @api private
  def regexp
    return @regexp if defined? @regexp
    return @regexp = expected.message if Regexp === expected.message
    return @regexp = nil unless expected.message =~ /\A\(\?([mix]*)(-[mix]+)?:(.*)\)\z/
    @regexp = Regexp.new($3,
                         0 |
                         ($1.include?('m') ? Regexp::MULTILINE : 0) |
                         ($1.include?('i') ? Regexp::IGNORECASE : 0) |
                         ($1.include?('x') ? Regexp::EXTENDED : 0))
  end
end
