# -*- coding: utf-8 -*-

# The difflib algorithm is based on the algorithm employed by the difflib
# library for Python, which is, in turn, based on an algorithm by Ratcliff and
# Obershelp.
#
# It’s implemented as an Enumerable over the {Match}es between two sequences,
# which makes it useful for a wide class of objects.
#
# @see http://docs.python.org/library/difflib.html
class Lookout::Diff::Algorithms::Difflib
  include Enumerable

  # Initializes the algorithm object.  Optionally takes a block to determine
  # what elements in _to_ are to be ignored.  This can be used to, for example,
  # ignore whitespace differences.
  #
  # The elements in _from_ and _to_ must respond to #hash and #==.
  #
  # @param [#[]] from The original Enumerable
  # @param [#[]] to The new Enumerable that _from_ should become
  # @yieldparam element
  # @yieldreturn [Boolean]
  def initialize(from, to, &ignorable)
    @from, @to, @ignorable = from, to, ignorable
  end

  # @overload
  #   Enumerates the matches between the two sequences.  There will always be
  #   at least one match yielded, the one at the end of the sequences.
  #
  #   @yieldparam [Match] match
  #   @return [self]
  # @overload
  #   @return [Enumerator] An Enumerator over the matches between the two
  #     sequences
  def each
    return enum_for(__method__) unless block_given?
    current = Lookout::Diff::Match.new(Lookout::Diff::Range.new(@from, 0...0),
                                       Lookout::Diff::Range.new(@to, 0...0))
    stack = [Position.origin(@from, @to, &@ignorable)]
    until stack.empty?
      case item = stack.pop
      when Position
        match = item.match
        next if match.empty?
        stack.push item.begin_after(match) if item.ends_after? match
        stack.push match
        stack.push item.end_before(match) if item.begins_before? match
      when Lookout::Diff::Match
        if current.touches? item
          current += item
        else
          yield current unless current.empty?
          current = item
        end
      end
    end
    yield current unless current.empty?
    yield current.at(@from.size...@from.size, @to.size...@to.size)
    self
  end
end
