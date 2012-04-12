# -*- coding: utf-8 -*-

# Proxy for objects that should be literally expected.  This is achieved by
# overriding #to_lookout_expected to wrap the object in a
# {Lookout::Expected::Object} instead of using whatever #to_lookout_expected on
# the object would normally return.  This allows us to expect a literal {Range}
# instead of allowing either a Range or an item included in the range.
class Lookout::Literal
  # @param [Object] subject The test subject (expected value) that should be
  #   matched literally
  def initialize(subject)
    @subject = subject
  end

  # @param [Lookout::Literal] other
  # @return [Boolean] True if the receiver’s class and subject `#==` those of
  #   _other_
  def ==(other)
    self.class == other.class and
      subject == other.subject
  end

  alias eql? ==

  def hash
    self.class.hash ^ subject.hash
  end

  def inspect
    'literal(%p)' % output
  end

  # @return [Lookout::Expected::Object] An expected value wrapper around the
  #   subject
  def to_lookout_expected
    Lookout::Expected::Object.new(@subject)
  end

  protected

  attr_reader :subject
end
