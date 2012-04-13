# -*- coding: utf-8 -*-

# Represents a matching pair of {Slice}s of the sequences being “diffed”.
class Lookout::Diff::Match
  include Comparable

  # @param [Slice] from The slice of the original sequence
  # @param [Slice] to The slice of the new sequence
  def initialize(from, to)
    @from, @to = from, to
  end

  # @return True if the match is empty
  def empty?
    from.empty?
  end

  # @return [Integer] The number of matching elements
  def size
    from.size
  end

  # @param [Match] other
  # @return [Match] A new match encompassing the slices of the receiver and
  #   _other_
  # @note Logically, the receiver should {#touch?} _other_, but this isn’t
  #   enforced.
  def +(other)
    self.class.new(from + other.from, to + other.to)
  end

  # @param [Match] other
  # @return True if {#from} and {#to} {Slice#touch? #touch?} those of _other_
  def touch?(other)
    from.touch? other.from and to.touch? other.to
  end

  def <=>(other)
    return nil unless self.class == other.class
    (from <=> other.from).nonzero? or
      (to <=> other.to).nonzero? or
      0
  end

  # @return [Boolean]
  alias eql? ==

  def inspect
    '#<%s %p==%p>' % [self.class, from, to]
  end

  # @param [Range] from
  # @param [Range] to
  # @return [Match] A new match with {#from} and {#to} {Slice#at #at} _from_
  #   and _to_
  def at(from, to)
    self.class.new(self.from.at(from), self.to.at(to))
  end

  # @return [Slice] The slice of the original sequence
  attr_reader :from

  # @return [Slice] The slice of the new sequence
  attr_reader :to
end
