# -*- coding: utf-8 -*-

class Lookout::Diff::Algorithms::Difflib::Position::New <
      Lookout::Diff::Slice
  def initialize(items, range = 0...items.size, indexes = nil)
    super items, range
    @indexes = indexes
  end

  def each_index(item)
    indexes[item].each do |index|
      next if index < range.begin
      break if index > range.end
      yield index
    end
  end

  def indexes
    return @indexes if @indexes
    @indexes = Hash.new{ |h, k| h[k] = [] }
    each = items.is_a?(String) ?
        (' '[0].is_a?(Integer) ? :each_byte : :each_char) :
        :each
    i = 0
    items.send(each) do |item|
      @indexes[item] << i
      i += 1
    end
    @indexes
  end

  def begin_after(other) self.class.new(items, other.end + 1..self.end, indexes) end
  def end_before(other) self.class.new(items, self.begin...other.begin, indexes) end
  def at(range) Lookout::Diff::Slice.new(items, range) end
  def ==(other) super and indexes == other.indexes end
  alias eql? ==
  def hash; @hash ||= super ^ indexes.hash end
end
