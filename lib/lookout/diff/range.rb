# -*- coding: utf-8 -*-

# Represents a range of a sequence being “diffed”.
class Lookout::Diff::Range
  include Enumerable, Comparable

  # @param [Enumerable] items Sequence being “diffed”
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

  # @param [Range] other
  # @return True if {#end} + 1 = _other_{#begin}
  def touch?(other)
    self.end + 1 == other.begin
  end

  # @param [Range] other
  # @return True if {#begin} < _other_{#begin}
  def begin_before?(other)
    self.begin < other.begin
  end

  # @param [Range] other
  # @return True if {#end} > _other_{#end}
  def end_after?(other)
    self.end > other.end
  end

  # @param [Range] other
  # @return [Range] A new range beginning at _other_{#end} + 1
  def begin_after(other)
    begin_at(other.end + 1)
  end

  # @param [Range] other
  # @return [Range] A new range ending at _other_{#begin} - 1
  def end_before(other)
    end_at(other.begin - 1)
  end

  # @param [::Range] range
  # @return [Range] A new range spanning the items of _range_
  def at(range)
    self.class.new(items, range)
  end

  # @param [Range] other
  # @return [Range] A new range encompassing the receiver and _other_
  # @note Logically, the receiver should {#touch?} _other_, but this isn’t
  #   enforced.
  def +(other)
    at(self.begin..other.end)
  end

  # @param [Integer] index
  # @return [Range] A new range beginning at _index_
  def begin_at(index)
    at(index..self.end)
  end

  # @param [Integer] index
  # @return [Range] A new range ending at _index_
  def end_at(index)
    at(self.begin..index)
  end

  # @overload
  #   Enumerates the receiver’s elements.
  #
  #   @yieldparam element
  #   @return [self]
  # @overload
  #   @return [Enumerator] An Enumerator over the receiver’s elements
  def each
    return enum_for(__method__) unless block_given?
    range.each do |index|
      yield items[index]
    end
    self
  end

  # @overload
  #   Enumerates the receiver’s elements and their indexes.
  #
  #   @yieldparam element
  #   @yieldparam [Integer] index
  #   @return [self]
  # @overload
  #   @return [Enumerator] An Enumerator over the receiver’s elements and their
  #     indexes
  def each_with_index
    return enum_for(__method__) unless block_given?
    range.each do |index|
      yield items[index], index
    end
    self
  end

  # @return [Enumerable] The subsequence represented by the receiver
  def to_items
    items[range]
  end

  # @param [Integer] index
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

  def <=>(other)
    return nil unless self.class == other.class and items == other.items
    (self.begin <=> other.begin).nonzero? or
      (self.end <=> other.end).nonzero? or
      0
  end

  # @return [Boolean]
  alias eql? ==

  def inspect
    '%p[%p]' % [items, range]
  end

  protected

  attr_reader :items, :range
end
