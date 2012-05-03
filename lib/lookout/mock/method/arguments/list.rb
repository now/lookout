# -*- coding: utf-8 -*-

# Arguments matcher matching a list of arguments.  It uses
# {Lookout::Difference} to do the actual work.
class Lookout::Mock::Method::Arguments::List
  # Expects _args_.
  # @param [Object, …] *args
  Value(:'*args')

  # @param [Array<Object>] other
  # @return True if there are no {Lookout::Difference differences} between the
  #   expected arguments and _other_
  def =~(other)
    not args.to_lookout_expected.difference(other)
  end

  # @return The receiver as a String argument list
  def to_s
    Lookout::Inspect::Argument.list(*args)
  end

  # @return [Object, Array<Object>] The expected arguments
  def to_a
    args.to_a
  end
end
