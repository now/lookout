# -*- coding: utf-8 -*-

# Sequence of {Operation}s based on a sequence of {Match}es.  Each match is
# turned into a {Copy}, {Delete}, {Insert}, or {Replace} operation based on its
# relation to other matches in the sequence of matches.  Empty copy operations
# will never be a part of this sequence.
class Lookout::Diff::Operations
  # Initializes a sequence of operations based on _matches_.
  # @param [Matches] matches
  Value(:matches)
  include Enumerable

  # @overload
  #   Enumerates the operations.
  #
  #   @yieldparam [Operation] operation
  #   @return [self]
  # @overload
  #   @return [Enumerator] An Enumerator over the operations
  def each
    return enum_for(__method__) unless block_given?
    old = new = 0
    matches.each do |match|
      type = if    old < match.old.begin and new < match.new.begin then Replace
             elsif old < match.old.begin                           then Delete
             elsif new < match.new.begin                           then Insert
             else                                                       Copy
             end
      yield type.new(match.old.at(old...match.old.begin),
                     match.new.at(new...match.new.begin)) unless type == Copy
      yield Copy.new(match.old, match.new) unless match.empty?
      old, new = match.old.end + 1, match.new.end + 1
    end
    self
  end
end
