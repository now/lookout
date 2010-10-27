# -*- coding: utf-8 -*-

class Lookout::Diff::Algorithm::Difflib::Position::From
  def initialize(items, range = 0...items.size)
    @items, @range = items, range
  end

  def begin
    range.begin
  end

  def end
    range.end - (range.exclude_end? ? 1 : 0)
  end

  def [](index)
    items[index]
  end

  def each_with_index
    range.each do |index|
      yield items[index], index
    end
    self
  end

  def begin_at(beginning)
    self.class.new(items, beginning...range.end)
  end

  def end_at(ending)
    self.class.new(items, range.begin...ending)
  end

  def ==(other)
    items == other.items and range == other.range
  end

  def inspect
    '%p[%p]' % [items, range]
  end

protected

  attr_reader :items, :range
end
