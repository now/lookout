# -*- coding: utf-8 -*-

# A {Group} represents an ordered sequence of related {Operation}s and is the
# type enumerated by {Groups}.
class Lookout::Diff::Group
  include Enumerable

  # Initializes the group object with an initial sequence of operations.
  #
  # @param [Array<Operation>] operations Initial sequence of operations in this
  #   group
  def initialize(*operations)
    @operations = operations
  end

  # @return [Boolean] True if this group doesn’t contain any operations
  def empty?
    operations.empty?
  end

  # Adds an operation to this group.
  #
  # @param [Operation] operation The operation to add.
  # @return [Group] self
  def <<(operation)
    operations << operation
    self
  end

  # Folds the last operation in this group.
  #
  # @param [Integer] context The number of elements to leave as context
  # @return [Group] self
  def fold(context)
    operations[-1] = operations[-1] << context
    self
  end

  # @return [Boolean] True if this group contains one operation and that
  #   operation represents parity
  def parity?
    operations.size == 1 and operations.first.parity?
  end

  # @overload
  #   Enumerates the operations in this group.
  #
  #   @yieldparam [Operation] operation The operation
  #   @return [Group] self
  # @overload
  #   @return [Enumerator] An Enumerator over the operations in this group
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

  # @param [Group] other Group to compare this group to
  # @return [Boolean] True if this group is equal to _other_
  def ==(other)
    self.class == other.class and
      operations == other.operations
  end

  # @return [String] The inspection of this group
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
