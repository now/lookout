# -*- coding: utf-8 -*-

# Ordered sequence of related {Operation}s; type enumerated by {Groups}.
class Lookout::Diff::Group
  # Initializes the group with an initial sequence of _operations_.
  # @param [Operation, …] operations
  Value(:'*operations')
  include Enumerable

  # @return True if the receiver doesn’t contain any operations
  def empty?; operations.empty? end

  # Adds _operation_ to the receiver.
  #
  # @param [Operation] operation
  def <<(operation) operations << operation; self end

  # {Operation#<< Folds} the last operation, leaving _context_ elements of
  # context.
  #
  # @param [Integer] context
  # @return [self]
  def fold(context) operations[-1] = operations[-1] << context; self end

  # @return True if the receiver contains one operation and that operation
  #   represents {Operation#parity? parity}
  def parity?
    operations.size == 1 and operations.first.parity?
  end

  # @overload
  #   Enumerates the operations.
  #
  #   @yieldparam [Operation] operation
  # @overload
  #   @return [Enumerator<Operation>] An Enumerator over the operations
  def each
    return enum_for(__method__) unless block_given?
    operations.each do |operation| yield operation end
    self
  end

  # @return [Slice] The slice of the old sequence between the first operation’s
  #   beginning and the last operation’s end
  def old; slice(:old) end

  # @return [Slice] The slice of the new sequence between the first operation’s
  #   beginning and the last operation’s end
  def new; slice(:new) end

  private

  def slice(target)
    # TODO: Should be #end_after(operations.last.send(target))
    operations.first.send(target).end_at(operations.last.send(target).end)
  end
end
