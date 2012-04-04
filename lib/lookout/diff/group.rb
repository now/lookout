# -*- coding: utf-8 -*-

# A {Group} represents an ordered sequence of related {Operation}s and is the
# type enumerated by {Groups}.
class Lookout::Diff::Group
  include Enumerable

  # @param [Array<Operation>] operations Initial sequence of operations
  def initialize(*operations)
    @operations = operations
  end

  # @return [Boolean] True if the receiver doesn’t contain any operations
  def empty?
    operations.empty?
  end

  # Adds _operation_ to the receiver.
  #
  # @param [Operation] operation
  # @return [self]
  def <<(operation)
    operations << operation
    self
  end

  # {Operation#<< Folds} the last operation, leaving _context_ elements of
  # context.
  #
  # @param [Integer] context
  # @return [self]
  def fold(context)
    operations[-1] = operations[-1] << context
    self
  end

  # @return [Boolean] True if the receiver contains one operation and that
  #   operation represents {Operation#parity? parity}
  def parity?
    operations.size == 1 and operations.first.parity?
  end

  # @overload
  #   Enumerates the operations.
  #
  #   @yieldparam [Operation] operation
  #   @return [self]
  # @overload
  #   @return [Enumerator] An Enumerator over the operations
  def each
    return enum_for(__method__) unless block_given?
    operations.each do |operation|
      yield operation
    end
    self
  end

  # @return [Range] The range of the original sequence between the first
  #   operation’s beginning and the last operation’s end
  def from
    range(:from)
  end

  # @return [Range] The range of the new sequence between the first operation’s
  #   beginning and the last operation’s end
  def to
    range(:to)
  end

  # @param [Group] other
  # @return [Boolean] True if the receiver’s class and operations `#==` those of
  #   _other_
  def ==(other)
    self.class == other.class and
      operations == other.operations
  end

  def inspect
    '#<%s %p>' % [self.class, operations]
  end

  protected

  attr_reader :operations

  private

  def range(target)
    # TODO: Should be #end_after(operations.last.send(target))
    operations.first.send(target).end_at(operations.last.send(target).end)
  end
end
