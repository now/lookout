# -*- coding: utf-8 -*-

# Represents the expect block of {Expected::Object}s.  This is the base expect
# block class and may be subclassed if some special equality checking needs to
# be performed, if the execution environment needs to be set up in some way
# before the expect block is executed, or if the expect block should receive
# other arguments than the default (being the expected value).
class Lookout::Expect::Object
  include Comparable

  # Sets up the expect block for execution on #call.
  # @param [Expected::Object] expected The expected object
  # @param [::String] file The expanded path to the file containing the
  #   expectation
  # @param [::Integer] line The line in _file_ on which the expectation is
  #   defined
  # @yieldparam [::Object] subject The expected value
  # @yieldreturn [::Object] The actual result
  def initialize(expected, file, line, &block)
    @expected, @file, @line, @block = expected, file, line, block
  end

  # Evaluates the expect block and checks for differences between its result
  # and the expected value.
  # @return [Lookout::Results::Error] If an Exception is raised
  # @return (see #check)
  def call
    check(evaluate_block)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end

  def <=>(other)
    return nil unless self.class == other.class
    (file <=> other.file).nonzero? or
      (line <=> other.line).nonzero? or
      0
  end

  protected

  # @return [::String] The expanded path to the file containing the expectation
  attr_reader :file

  # @return [::Integer] The line in #file on which the expectation is defined
  attr_reader :line

  private

  # Evaluates the expect block in the proper context and returns its result.
  # @param [::Object] subject The test subject (expected value) to pass to the
  #   expect block
  # @return [::Object] The actual result of evaluating the expect block
  def evaluate_block(subject = @expected.subject)
    Context.new(subject, &@block).evaluate
  end

  # Checks for differences between the actual result of evaluating the expect
  # block and the expected value.
  # @param [::Object] actual The actual result of evaluating the expect block
  # @return [Lookout::Results::Success] If there are no differences between the
  #   actual result and the expected value
  # @return [Lookout::Results::Failure] If there are differences between the
  #   actual result and the expected value
  def check(actual)
    (difference = @expected.difference(actual)) ?
      Lookout::Results::Failure.new(file, line, difference) :
      Lookout::Results::Success.new(file, line)
  end
end
