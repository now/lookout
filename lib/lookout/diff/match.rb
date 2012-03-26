# -*- coding: utf-8 -*-

# Represents a matching pair of {Range}s of the sequences being “diffed”.
class Lookout::Diff::Match
  include Comparable

  # @param [Range] from The range of the original sequence
  # @param [Range] to The range of the new sequence
  def initialize(from, to)
    @from, @to = from, to
  end

  # @return [Boolean] True if the match is empty
  def empty?
    from.empty?
  end

  # @return [Boolean] The number of matching elements
  def size
    from.size
  end

  # Returns a new match encompassing the ranges of self and _other_.
  # Logically, _other_ should be touching self, that is, {#touches?}(_other_),
  # but this isn’t enforced.
  #
  # @param [Match] other The match to extend self with
  # @return [Match] A new match encompassing the ranges of self and _other_
  def +(other)
    self.class.new(from + other.from, to + other.to)
  end

  def touches?(other)
    from.touches? other.from and to.touches? other.to
  end

  def <=>(other)
    return nil unless self.class == other.class
    (from <=> other.from).nonzero? or
      (to <=> other.to).nonzero? or
      0
  end

  alias eql? ==

  def inspect
    '#<%s %p==%p>' % [self.class, from, to]
  end

  def at(from, to)
    self.class.new(self.from.at(from), self.to.at(to))
  end

  attr_reader :from, :to
end
