# -*- coding: utf-8 -*-

class Lookout::Diff::Algorithm::Difflib::Position
  autoload :To, 'lookout/diff/algorithm/difflib/position/to'

  class << self
    def origin(from, to)
      to = To.new(to)
      new(Lookout::Diff::Range.new(from),
          to,
          block_given? ?
            to.indexes.reduce({}){ |j, (k, v)| j[k] = yield(k); j } :
            {})
    end
  end

  def initialize(from, to, junk)
    @from, @to, @junk = from, to, junk
  end

  def match
    match = leftmost_longest
    junk.empty? ? match : expand(expand(match, false), true)
  end

  def begins_before?(match)
    from.begins_before? match.from and to.begins_before? match.to
  end

  def ends_after?(match)
    from.ends_after? match.from and to.ends_after? match.to
  end

  def begin_after(match)
    self.class.new(from.begin_after(match.from), to.begin_after(match.to), junk)
  end

  def end_before(match)
    self.class.new(from.end_before(match.from), to.end_before(match.to), junk)
  end

  def ==(other)
    from == other.from and to == other.to and junk == other.junk
  end

  def inspect
    '#<%s %p,%p>' % [self.class, from, to]
  end

protected

  attr_reader :from, :to, :junk

private

  def leftmost_longest
    match = Lookout::Diff::Match.new(@from.at(0...0), @to.at(0...0))
    sizes = Hash.new(0)
    @from.each_with_index do |item, from|
      _sizes = Hash.new(0)
      @to.each_index(item) do |to|
        size = _sizes[to] = sizes[to - 1] + 1
        match = Lookout::Diff::Match.
          new(@from.at(from - size + 1..from),
              @to.at(to - size + 1..to)) if size > match.size
      end unless junk[item]
      sizes = _sizes
    end
    match
  end

  def expand(match, junking)
    from_begin, to_begin = match.from.begin, match.to.begin
    while from_begin > @from.begin and to_begin > @to.begin and
          junk[@to[to_begin - 1]] ^ !junking and
          @from[from_begin - 1] == @to[to_begin - 1]
      from_begin -= 1
      to_begin -= 1
    end

    from_end, to_end = match.from.end, match.to.end
    while from_end + 1 <= @from.end and to_end + 1 <= @to.end and
          junk[@to[to_end + 1]] ^ !junking and
          @from[from_end + 1] == @to[to_end + 1]
      from_end += 1
      to_end += 1
    end

    Lookout::Diff::Match.new(from.at(from_begin..from_end),
                             to.at(to_begin..to_end))
  end
end
