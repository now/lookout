# -*- coding: utf-8 -*-

class Lookout::Diff::Algorithm::Difflib::Position::To <
      Lookout::Diff::Algorithm::Difflib::Position::From
  def initialize(items, range = 0...items.size, indexes = nil)
    super items, range
    @indexes = indexes
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

  def begin_at(beginning)
    self.class.new(items, beginning...range.end, indexes)
  end

  def end_at(ending)
    self.class.new(items, range.begin...ending, indexes)
  end

  def ==(other)
    super and indexes == other.indexes
  end
end
