# -*- coding: utf-8 -*-

# Expect block of {Expected::Object}s.  This is the base expect
# block class and may be subclassed if some special equality checking needs to
# be performed, if the execution environment needs to be set up in some way
# before the expect block is executed, or if the expect block should receive
# other arguments than the default (being the expected value).
class Lookout::Expect::Object
  # Sets up the expect block on _line_ in _file_ (the expanded path) to
  # expect the value that _expected_ wraps, and using the block’s result as the
  # actual result to pass to {Expected::Object#difference} when {#call}ed.
  # @param [Expected::Object] expected The expected value wrapper
  # @param [::String] file The expanded path to the file containing the expectation
  # @param [::Integer] line The line in {#file} on which the expectation is defined
  # @yieldparam [::Object] expected
  # @yieldreturn [::Object]
  Value(:expected, :file, :line, :'&block')
  include Comparable

  # Evaluates the expect block and checks for differences between its result
  # and the expected value.
  # @return [Results::Error] If an Exception is raised
  # @return (see #check)
  def call
    check(evaluate_block)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, Lookout::Exception.new(e))
  end

  # @return [Integer, nil] The comparison of the receiver’s {#file} and {#line}
  #   against those of _other_
  def <=>(other)
    return nil unless self.class == other.class
    (file <=> other.file).nonzero? or
      (line <=> other.line).nonzero? or
      0
  end

  alias eql? ==

  private

  # @param [::Object, …] *args
  # @return [::Object] The actual result of evaluating the expect block in the
  #   proper context, passing _args_, which defaults to the expected value, to
  #   it
  # @see Context
  def evaluate_block(*args)
    (args.empty? ?
     Context.new(expected.expected, &block) :
     Context.new(*args, &block)).evaluate
  end

  # Checks for differences between the _actual_ result of evaluating the expect
  # block and the expected value.
  # @param [::Object] actual
  # @return [Results::Success] If there are no differences between the actual
  #   result and the expected value
  # @return [Results::Failure] If there are differences between the actual
  #   result and the expected value
  def check(actual)
    (difference = expected.difference(actual)) ?
      Lookout::Results::Failure.new(file, line, difference) :
      Lookout::Results::Success.new(file, line)
  end
end
