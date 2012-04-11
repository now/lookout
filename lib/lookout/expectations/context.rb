# -*- coding: utf-8 -*-

# Context in which expectations blocks are evaluated.  Plug-ins may add private
# methods to this class to make them available to expectations blocks.
class Lookout::Expectations::Context
  # @param [Proc] &block The block to call when an “expect” keyword is found
  def initialize(&block)
    @block = block
  end

  private

  # Sets up an expectation, expecting _subject_ and evaluating _&block_ for the
  # actual result, and passes it to the given block.
  # @param [Object] subject
  # @param [Proc] &block
  # @return [self]
  # @see Lookout::Expect.expect
  def expect(subject, &block)
    @block.call Lookout::Expect.expect(subject,
                                       *(block.respond_to?(:source_location) ?
                                         block.source_location :
                                         Lookout.location(caller.first)),
                                       &block)
    self
  end

  # @return [Lookout::Actual] A result wrapper for explicit query expectations
  def result
    Lookout::Actual.new
  end

  # @param [Object] subject
  # @return [Lookout::Literal] A literal expected value for _subject_
  def literal(subject)
    Lookout::Literal.new(subject)
  end

  # @return [Lookout::Mock::Object] A mock object
  def mock
    Lookout::Mock::Object.new
  end

  # @return [Lookout::Mock::Method::Arguments::None] An object representing
  #   “without arguments” for mock argument expectations
  def without_arguments
    Lookout::Mock::Method::Arguments::None.new
  end

  # @return [Lookout::Stub::Object] A stub object
  def stub
    Lookout::Stub::Object.new
  end

  # @param [String] string
  # @return [Lookout::Output] An expected output wrapper around _string_
  def output(string)
    Lookout::Output.new(string)
  end

  # @param [String] string
  # @return [Lookout::Output] An expected warning wrapper around _string_
  def warning(string)
    Lookout::Warning.new(string)
  end
end
