# -*- coding: utf-8 -*-

class Lookout::Diff::Range
  include Enumerable

  def initialize(items, range = 0...items.size)
    @items, @range = items, range.exclude_end? ? range.begin..range.end - 1 : range
  end

  def empty?
    size < 1
  end

  def size
    range.end - range.begin + 1
  end

  def begins_before?(other)
    range.begin < other.range.begin
  end

  def ends_after?(other)
    range.end > other.range.end
  end

  def begin_after(other)
    self.class.new(items, other.range.end + 1..range.end)
  end

  def end_before(other)
    self.class.new(items, range.begin...other.range.begin)
  end

  def at(range)
    self.class.new(items, range)
  end

  def +(other)
    self.class.new(items, range.begin..other.range.end)
  end

  def begin_at(index)
    self.class.new(items, index..range.end)
  end

  def end_at(index)
    self.class.new(items, range.begin..index)
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

  def ==(other)
    self.class == other.class and
      range == other.range and items == other.items
  end

  alias eql? ==

  def inspect
    '%p[%p]' % [items, range]
  end

  protected

  attr_reader :items, :range
end
