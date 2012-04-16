# -*- coding: utf-8 -*-

# The difflib algorithm is based on the algorithm employed by the difflib
# library for Python, which is, in turn, based on an algorithm by Ratcliff and
# Obershelp, see {http://docs.python.org/library/difflib.html}.
#
# It’s implemented as an Enumerable over the {Match}es between two sequences.
# There are very few requirements on these sequences (see {#initialize}), which
# makes this implementation useful for a wide class of objects.
class Lookout::Diff::Algorithms::Difflib
  include Enumerable

  # Initializes the algorithm to generate matches between the _old_ and _new_
  # versions of the indexable sequences.  The sequences must be indexable by
  # {::Range}s and Integers with the semantics that, for example, {::Array}s
  # have, and their elements must also respond to #hash and #==.
  #
  # A block may be given to determine what elements in _new_ are to be ignored.
  # This can be used to, for example, ignore whitespace differences.
  #
  # @param [#each, #[::Range, Integer]] old
  # @param [#each, #[::Range, Integer]] new
  # @yield [?]
  # @yieldparam element
  # @yieldreturn [Boolean]
  def initialize(old, new, &ignorable)
    @old, @new, @ignorable = old, new, ignorable
  end

  # @overload
  #   Enumerates the matches between the two sequences.  There’ll always be at
  #   least one match yielded, the {Match#empty? empty} one at the end of the
  #   sequences.
  #
  #   @yieldparam [Match] match
  #   @return [self]
  # @overload
  #   @return [Enumerator] An Enumerator over the matches between the two
  #     sequences
  def each
    return enum_for(__method__) unless block_given?
    current = Lookout::Diff::Match.new(Lookout::Diff::Slice.new(@old, 0...0),
                                       Lookout::Diff::Slice.new(@new, 0...0))
    stack = [Position.origin(@old, @new, &@ignorable)]
    until stack.empty?
      case item = stack.pop
      when Position
        match = item.match
        next if match.empty?
        stack.push item.begin_after(match) if item.end_after? match
        stack.push match
        stack.push item.end_before(match) if item.begin_before? match
      when Lookout::Diff::Match
        if current.touch? item
          current += item
        else
          yield current unless current.empty?
          current = item
        end
      end
    end
    yield current unless current.empty?
    yield current.at(@old.size...@old.size, @new.size...@new.size)
    self
  end
end
