# -*- coding: utf-8 -*-

# Context in which expectations blocks are evaluated.  Plug-ins may add private
# methods to this class to make them available to expectations blocks.
class Lookout::Expectations::Context
  # Sets up a context in which the given block will be passed each expect block
  # found in the expectations blocks evaluated in this context via
  #  #instance_eval.
  # @yieldparam [Expect] expect
  def initialize(&block) @block = block end

  private

  # Sets up an expect block, expecting EXPECTED and evaluating BLOCK for the
  # actual result, then passes it to the block given to the constructor.
  # @param (see Expect.expect)
  # @return [self]
  # @see Expect.expect
  def expect(expected, &block)
    @block.call Lookout::Expect.expect(expected,
                                       *(block.respond_to?(:source_location) ?
                                         block.source_location :
                                         Lookout.location(caller.first)),
                                       &block)
    self
  end

  # @return [Actual] A result wrapper for explicit query expectations
  def result; Lookout::Actual.new end

  # @param [Object] expected
  # @return [Literal] A literal expected value for EXPECTED
  def literal(expected) Lookout::Literal.new(expected) end

  # @param (see Stub::Object#initialize)
  # @return [Mock::Object] A mock object set up with METHODS
  def mock(methods = {}) Lookout::Mock.new(methods) end

  # @return [Mock::Method::Arguments::None] An object representing
  #   “without arguments” for mock argument expectations
  def without_arguments; Lookout::Reception::Arguments::None.new end

  # @param (see Stub::Object#initialize)
  # @return [Stub::Object] A stub object set up with METHODS
  def stub(methods = {}) Lookout::Stub.new(methods) end

  # @return [Output] An expected output wrapper around STRING
  def output(string) Lookout::Output.new(string) end

  # @return [Output] An expected warning wrapper around STRING
  def warning(string) Lookout::Warning.new(string) end
end
