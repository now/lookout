# -*- coding: utf-8 -*-

# Sequence of {Operations} bundled together into {Group}s that can then be used
# to show the subsequences that differ, folding away the subsequences that are
# the same, only keeping some context around the folding points.
class Lookout::Diff::Groups
  # Initializes the sequence with the _operations_ to group and the number of
  # elements to leave as _context_.
  #
  # @param [Operations] operations
  # @param [Integer] context
  Value(:operations, [:context, 3])
  include Enumerable

  # @overload
  #   Enumerates the groups of operations.
  #
  #   @yieldparam [Group] group
  # @overload
  #   @return [Enumerator<Group>] An Enumerator over the groups of operations
  def each
    return enum_for(__method__) unless block_given?
    saved = nil
    group = Lookout::Diff::Group.new
    operations.each do |operation|
      if saved
        yield saved
        saved = nil
      end
      if group.empty?
        operation = operation >> context
        group << operation
      elsif operation.foldable? context
        saved = group << (operation << context)
        group = Lookout::Diff::Group.new(operation >> context)
      else
        group << operation
      end
    end
    if saved
      yield saved
    elsif not group.empty?
      yield group.fold(context)
    end
    self
  end
end
