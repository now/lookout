# -*- coding: utf-8 -*-

# Arguments matcher matching a list of arguments.  It uses
# {Lookout::Difference} to do the actual work.
class Lookout::Reception::Arguments::List
  # Expects ARGS.
  # @param [Object, …] args
  Value(:'*args')

  # @param [Array<Object>] other
  # @return True if there are no {Expected::Object#difference
  #   differences} between the expected arguments and OTHER
  def =~(other) not args.to_lookout_expected.difference(other) end

  # @return The receiver as a String argument list
  def to_s; Lookout::Inspect.args(*args) end
end
