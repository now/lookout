# -*- coding: utf-8 -*-

# Represents expected {::Object}s.  This is the base expected-value class and
# may be subclassed if you have a type that would benefit from more specific
# treatment than what this class affords.  Such a subclass should override
# {#expect} and/or {#difference} to set up type-specific expect blocks and/or
# difference checks and difference report generation.
class Lookout::Expected::Object
  # @param [::Object] subject The test subject (expected value)
  def initialize(subject)
    @subject = subject
  end

  # @param (see Lookout::Expect::Object#initialize)
  # @yieldparam (see Lookout::Expect::Object#initialize)
  # @yieldreturn (see Lookout::Expect::Object#initialize)
  # @return [Lookout::Expect::Object] An expect block for the receiver
  def expect(file, line, &block)
    Lookout::Expect::Object.new(self, file, line, &block)
  end

  # @param [::Object] other
  # @return [Lookout::Difference::Object, nil] A difference report generator
  #   between _other_ and {#subject}, unless they’re `#==`
  def difference(other)
    Lookout::Difference::Object.new(other, subject) unless subject == other
  end

  # @param [Lookout::Expected::Object] other
  # @return [Boolean] True if the receiver’s class and {#subject} `#==` those
  #   of _other_
  def ==(other)
    self.class == other.class and
      subject == other.subject
  end

  alias eql? ==

  # @return [::Object] The test subject (expected value)
  attr_reader :subject
end
