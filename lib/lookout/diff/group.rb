# -*- coding: utf-8 -*-

# A {Lookout::Diff::Group} represents an ordered sequence of related
# {Lookout::Diff::Operation}s and is the type enumerated by
# {Lookout::Diff::Groups}.
class Lookout::Diff::Group
  include Enumerable

  # Initializes the group object with an initial sequence of operations.
  #
  # @param [Array<Lookout::Diff::Operation>] operations Initial sequence of operations in this group
  def initialize(*operations)
    @operations = operations
  end

  # @return [Boolean] True if this group doesn’t contain any operations
  def empty?
    operations.empty?
  end

  # Adds an operation to this group.
  #
  # @param [Lookout::Diff::Operation] operation The operation to add.
  # @return [Lookout::Diff::Group] self
  def <<(operation)
    operations << operation
    self
  end

  # Folds the last operation in this group.
  #
  # @param [Integer] context The number of elements to leave as context
  # @return [Lookout::Diff::Group] self
  def fold(context)
    operations[-1] = operations[-1] << context
    self
  end

  # @return [Boolean] True if this group contains one operation and that
  #   operation represents parity
  def parity?
    operations.size == 1 and operations.first.parity?
  end

  # Enumerates the operations in this group.
  #
  # @yieldparam [Lookout::Diff::Operation] operation The operation
  # @return [Lookout::Diff::Group] self
  # @return [Enumerator] An Enumerator over the operations in this group, if no
  #   block was given
  def each
    return enum_for(__method__) unless block_given?
    operations.each do |operation|
      yield operation
    end
    self
  end

  # @return [Lookout::Diff::Range] The range of the original sequence between
  #   the first operation’s beginning and the last operation’s end
  def from
    range(:from)
  end

  # @return [Lookout::Diff::Range] The range of the new sequence between
  #   the first operation’s beginning and the last operation’s end
  def to
    range(:to)
  end

  # @param [Lookout::Diff::Group] other Group to compare this group to
  # @return [Boolean] True if this group is equal to _other_
  def ==(other)
    self.class == other.class and
      operations == other.operations
  end

  # @return [String] Inspection of this group
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
