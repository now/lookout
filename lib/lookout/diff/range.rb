# -*- coding: utf-8 -*-

class Lookout::Diff::Range
  include Enumerable, Comparable

  def initialize(items, range = 0...items.size)
    @items, @range = items, range.exclude_end? ? range.begin..range.end - 1 : range
  end

  def empty?
    size < 1
  end

  def size
    self.end - self.begin + 1
  end

  def touches?(other)
    self.end + 1 == other.begin
  end

  def begins_before?(other)
    self.begin < other.begin
  end

  def ends_after?(other)
    self.end > other.end
  end

  def begin_after(other)
    self.class.new(items, other.end + 1..self.end)
  end

  def end_before(other)
    self.class.new(items, self.begin...other.begin)
  end

  def at(range)
    self.class.new(items, range)
  end

  def +(other)
    self.class.new(items, self.begin..other.end)
  end

  def begin_at(index)
    self.class.new(items, index..self.end)
  end

  def end_at(index)
    self.class.new(items, self.begin..index)
  end

  def each
    return enum_for(__method__) unless block_given?
    range.each do |index|
      yield items[index]
    end
    self
  end

  def each_with_index
    return enum_for(__method__) unless block_given?
    range.each do |index|
      yield items[index], index
    end
    self
  end

  def to_items
    items[range]
  end

  def [](index)
    items[index]
  end

  def begin
    range.begin
  end

  def end
    range.end
  end

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
