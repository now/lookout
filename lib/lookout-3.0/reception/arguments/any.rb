# -*- coding: utf-8 -*-

# Arguments matcher matching any arguments.
class Lookout::Reception::Arguments::Any
  # @param [Array<Object>] other
  # @return [true]
  def =~(other) true end

  # @return True if the receiver’s class `#==` that of OTHER
  def ==(other) self.class == other.class end
  alias eql? ==
  def hash; self.class.hash end

  # @return The receiver as a String argument list
  def to_s; '*args, &block' end
end
