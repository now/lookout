# -*- coding: utf-8 -*-

# Represents a range of a sequence being “diffed”.
class Lookout::Diff::Range
  include Enumerable, Comparable

  # @param [Enumerable] items Sequence being “diffed” that this range is a part
  #   of
  # @param [::Range] range The range of _items_ being represented
  def initialize(items, range = 0...items.size)
    @items, @range = items, range.exclude_end? ? range.begin..range.end - 1 : range
  end

  # @return True if this range doesn’t include any elements
  def empty?
    size < 1
  end

  # @return [Integer] The number of elements in this range
  def size
    self.end - self.begin + 1
  end

  # @param [Range] other The range to check against
  # @return True if {#end} + 1 = _other_{#begin}
  def touches?(other)
    self.end + 1 == other.begin
  end

  # @param [Range] other The range to compare against
  # @return True if {#begin} < _other_{#begin}
  def begins_before?(other)
    self.begin < other.begin
  end

  # @param [Range] other The range to compare against
  # @return True if {#end} > _other_{#end}
  def ends_after?(other)
    self.end > other.end
  end

  # @param [Range] other The range to begin after
  # @return [Range] A new range beginning at _other_{#end} + 1
  def begin_after(other)
    begin_at(other.end + 1)
  end

  # @param [Range] other The range to end before
  # @return [Range] A new range ending at _other_{#begin} - 1
  def end_before(other)
    end_at(other.begin - 1)
  end

  # @param [::Range] range The range to set this range at
  # @return [Range] A new range spanning the items of _range_
  def at(range)
    self.class.new(items, range)
  end

  # Returns a new range encompassing self and _other_.
  # Logically, _other_ should be touching self, that is, {#touches?}(_other_),
  # but this isn’t enforced.
  #
  # @param [Range] other The range to extend self with
  # @return [Range] A new range encompassing self and _other_
  def +(other)
    at(self.begin..other.end)
  end

  # @param [Integer] index Index into the sequence to begin this range at
  # @return [Range] A new range beginning at _index_
  def begin_at(index)
    at(index..self.end)
  end

  # @param [Integer] index Index into the sequence to end this range at
  # @return [Range] A new range ending at _index_
  def end_at(index)
    at(self.begin..index)
  end

  # @overload
  #   Enumerates the elements in this range.
  #
  #   @yieldparam [Operation] element The element
  #   @return [Range] self
  # @overload
  #   @return [Enumerator] An Enumerator over the elements in this range
  def each
    return enum_for(__method__) unless block_given?
    range.each do |index|
      yield items[index]
    end
    self
  end

  # @overload
  #   Enumerates the elements and indexes of this range.
  #
  #   @yieldparam [Operation] element The element
  #   @yieldparam [Integer] index The index of the element
  #   @return [Range] self
  # @overload
  #   @return [Enumerator] An Enumerator over the elements in this range
  def each_with_index
    return enum_for(__method__) unless block_given?
    range.each do |index|
      yield items[index], index
    end
    self
  end

  # @return [Enumerable] The subsequence represented by this range
  def to_items
    items[range]
  end

  # @param [Integer] index The index of the element to retrieve
  # @return The _index_:th element
  def [](index)
    items[index]
  end

  # @return [Integer] The index of the first element
  def begin
    range.begin
  end

  # @return [Integer] The index of the last element
  def end
    range.end
  end

  # @private
  def <=>(other)
    return nil unless self.class == other.class and items == other.items
    (self.begin <=> other.begin).nonzero? or
      (self.end <=> other.end).nonzero? or
      0
  end

  alias eql? ==

  # @private
  def inspect
    '%p[%p]' % [items, range]
  end

  protected

  attr_reader :items, :range
end
