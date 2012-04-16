# -*- coding: utf-8 -*-

# Slice (subsequence) of a sequence being “diffed”.
class Lookout::Diff::Slice
  include Enumerable, Comparable

  # Initializes a slice of _items_ encompassing _range_.
  # @param [Enumerable] items
  # @param [Range] range
  def initialize(items, range = 0...items.size)
    @items, @range = items, range.exclude_end? ? range.begin..range.end - 1 : range
  end

  # @return True if {#size} < 1
  def empty?
    size < 1
  end

  # @return [Integer] The number of encompassed elements
  def size
    self.end - self.begin + 1
  end

  # @param [Slice] other
  # @return True if {#end} + 1 = _other_{#begin}
  def touch?(other)
    self.end + 1 == other.begin
  end

  # @param [Slice] other
  # @return True if {#begin} < _other_{#begin}
  def begin_before?(other)
    self.begin < other.begin
  end

  # @param [Slice] other
  # @return True if {#end} > _other_{#end}
  def end_after?(other)
    self.end > other.end
  end

  # @param [Slice] other
  # @return [Slice] A new slice beginning at _other_{#end} + 1
  def begin_after(other)
    begin_at(other.end + 1)
  end

  # @param [Slice] other
  # @return [Slice] A new slice ending at _other_{#begin} - 1
  def end_before(other)
    end_at(other.begin - 1)
  end

  # @param [Range] range
  # @return [Slice] A new slice encompassing _range_
  def at(range)
    self.class.new(items, range)
  end

  # @param [Slice] other
  # @return [Slice] A new slice encompassing the receiver and _other_
  # @note Logically, the receiver should {#touch?} _other_, but this isn’t
  #   enforced.
  def +(other)
    at(self.begin..other.end)
  end

  # @param [Integer] index
  # @return [Slice] A new slice beginning at _index_
  def begin_at(index)
    at(index..self.end)
  end

  # @param [Integer] index
  # @return [Slice] A new slice ending at _index_
  def end_at(index)
    at(self.begin..index)
  end

  # @overload
  #   Enumerates the encompassed elements.
  #
  #   @yieldparam element
  #   @return [self]
  # @overload
  #   @return [Enumerator] An Enumerator over the encompassed elements
  def each
    return enum_for(__method__) unless block_given?
    range.each do |index|
      yield items[index]
    end
    self
  end

  # @overload
  #   Enumerates the encompassed elements and their indexes.
  #
  #   @yieldparam element
  #   @yieldparam [Integer] index
  #   @return [self]
  # @overload
  #   @return [Enumerator] An Enumerator over the encompassed elements and
  #     their indexes
  def each_with_index
    return enum_for(__method__) unless block_given?
    range.each do |index|
      yield items[index], index
    end
    self
  end

  # @return [Enumerable] The encompassed elements
  def to_items
    items[range]
  end

  # @param [Integer] index
  # @return The _index_’th element
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

  # @param [Slice] other
  # @return [Integer, nil] The comparison of the receiver’s {#begin} and {#end}
  #   against those of _other_
  def <=>(other)
    return nil unless self.class == other.class and items == other.items
    (self.begin <=> other.begin).nonzero? or
      (self.end <=> other.end).nonzero? or
      0
  end

  alias eql? ==

  def inspect
    '%p[%p]' % [items, range]
  end

  protected

  attr_reader :items, :range
end
