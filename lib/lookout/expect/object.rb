# -*- coding: utf-8 -*-

# Expect block of {Expected::Object}s.  This is the base expect
# block class and may be subclassed if some special equality checking needs to
# be performed, if the execution environment needs to be set up in some way
# before the expect block is executed, or if the expect block should receive
# other arguments than the default (being the expected value).
class Lookout::Expect::Object
  include Comparable

  # Sets up the expect block on _line_ in _file_ (the expanded path) to
  # expect the value that _expected_ wraps, and using the block’s result as the
  # actual result to pass to {Expected::Object#difference} when {#call}ed.
  # @param [Expected::Object] expected
  # @param [::String] file
  # @param [::Integer] line
  # @yieldparam [::Object] expected
  # @yieldreturn [::Object]
  def initialize(expected, file, line, &block)
    @expected, @file, @line, @block = expected, file, line, block
  end

  # Evaluates the expect block and checks for differences between its result
  # and the expected value.
  # @return [Results::Error] If an Exception is raised
  # @return (see #check)
  def call
    check(evaluate_block)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end

  # @param [Match] other
  # @return [Integer, nil] The comparison of the receiver’s {#file} and {#line}
  #   against those of _other_
  def <=>(other)
    return nil unless self.class == other.class
    (file <=> other.file).nonzero? or
      (line <=> other.line).nonzero? or
      0
  end

  protected

  # @return [::String] The expanded path to the file containing the expectation
  attr_reader :file

  # @return [::Integer] The line in {#file} on which the expectation is defined
  attr_reader :line

  private

  # Evaluates the expect block in the proper context and returns its result.
  # @param [::Object] expected The expected value to pass to the expect block
  # @return [::Object] The actual result of evaluating the expect block
  def evaluate_block(expected = @expected.expected)
    Context.new(expected, &@block).evaluate
  end

  # Checks for differences between the actual result of evaluating the expect
  # block and the expected value.
  # @param [::Object] actual The actual result of evaluating the expect block
  # @return [Results::Success] If there are no differences between the actual
  #   result and the expected value
  # @return [Results::Failure] If there are differences between the actual
  #   result and the expected value
  def check(actual)
    (difference = @expected.difference(actual)) ?
      Lookout::Results::Failure.new(file, line, difference) :
      Lookout::Results::Success.new(file, line)
  end
end
