# -*- coding: utf-8 -*-

# Represents a sequence of {Operations} that are bundled together into {Group}s
# that can then be used to show the subsequences that differ, folding away the
# subsequnces that are the same, only keeping some context around the folding
# points.
class Lookout::Diff::Groups
  include Enumerable

  # Initializes this group with its operations and the number of elements to
  # use as context.
  #
  # @param [Operations] operations Operations to group
  # @param [Integer] context The number of elements to leave as context
  def initialize(operations, context = 3)
    @operations, @context = operations, context
  end

  # @overload
  #   Enumerates the groups of operations.
  #
  #   @yieldparam [Group] group
  #   @return [self]
  # @overload
  #   @return [Enumerator] An Enumerator over the groups of operations
  def each
    return enum_for(__method__) unless block_given?
    saved = nil
    group = Lookout::Diff::Group.new
    @operations.each do |operation|
      if saved
        yield saved
        saved = nil
      end
      if group.empty?
        operation = operation >> @context
        group << operation
      elsif operation.foldable? @context * 2
        saved = group << (operation << @context)
        group = Lookout::Diff::Group.new(operation >> @context)
      else
        group << operation
      end
    end
    if saved
      yield saved
    elsif not group.empty?
      yield group.fold(@context)
    end
  end
end
