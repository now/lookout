# -*- coding: utf-8 -*-

# Arguments matcher matching a list of arguments.  It uses
# {Lookout::Difference} to do the actual work.
class Lookout::Mock::Method::Arguments::List
  # Expects _args_.
  # @param [Object, …] *args
  def initialize(*args)
    @args = args
  end

  # @param [Object] other
  # @return [Boolean] True if there are no {Lookout::Difference differences}
  #   between the expected arguments and _other_
  def =~(other)
    not args.to_lookout_expected.difference(other)
  end

  # @param [List] other
  # @return [Boolean] True if the receiver’s class and expected arguments `#==`
  #   those of _other_
  def ==(other)
    self.class == other.class and args == other.args
  end

  alias eql? ==

  def hash
    args.hash
  end

  # @return [String] The receiver as a String argument list
  def to_s
    Lookout::Inspect::Argument.list(*args)
  end

  # @return [Object, Array<Object>] The expected arguments
  def to_a
    args.to_a
  end

  protected

  attr_reader :args
end
