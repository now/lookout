# -*- coding: utf-8 -*-

# Represents expected {::Exception}s.
class Lookout::Expected::Exception < Lookout::Expected::Object
  # @param (see Object#expect)
  # @yieldparam (see Object#expect)
  # @yieldreturn (see Object#expect)
  # @return [Lookout::Expect::Exception] An expect block for the receiver
  def expect(file, line, &block)
    Lookout::Expect::Exception.new(self, file, line, &block)
  end

  # @param [::Exception] other
  # @return [Lookout::Difference::Exception, nil] A difference report generator
  #   between _other_ and {#subject}, unless they’re #equal? or their classes
  #   are `#==` and their messages match or {#subject}s message is a Regexp
  #   that matches other’s message
  def difference(other)
    Lookout::Difference::Exception.new(other, subject, regexp) unless
      subject.equal?(other) or
      (subject.class == other.class and
       (other.respond_to? :message rescue false) and
       (m = other.message rescue nil) and
       (regexp ? regexp === m : subject.message == m))
  end

  private

  # The first test works in Ruby 1.8.  In Ruby 1.9, however, #message always
  # returns a String, unless the conversion raises an error.  Sadly, this
  # conversion can’t keep track of the ‘e’ and ‘n’ options for encoding
  # handling.
  # @api private
  def regexp
    return @regexp if defined? @regexp
    return @regexp = subject.message if Regexp === subject.message
    return @regexp = nil unless subject.message =~ /\A\(\?([mix]*)(-[mix]+)?:(.*)\)\z/
    @regexp = Regexp.new($3,
                         0 |
                         ($1.include?('m') ? Regexp::MULTILINE : 0) |
                         ($1.include?('i') ? Regexp::IGNORECASE : 0) |
                         ($1.include?('x') ? Regexp::EXTENDED : 0))
  end
end
