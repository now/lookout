# -*- coding: utf-8 -*-

class Lookout::Diff::Matches::Position
  class << self
    def origin(from, to)
      to = Lookout::Diff::Matches::To.new(to)
      new(Lookout::Diff::Matches::From.new(from),
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

  # TODO: #<
  def begins_before?(match)
    from.begin < match.from and to.begin < match.to
  end

  # TODO: #>
  def ends_after?(match)
    from.end >= match.from + match.size and to.end >= match.to + match.size
  end

  def begin_at(match)
    self.class.new(from.begin_at(match.from + match.size),
                   to.begin_at(match.to + match.size),
                   junk)
  end

  def end_at(match)
    self.class.new(from.end_at(match.from), to.end_at(match.to), junk)
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
    match = Lookout::Diff::Match.new(@from.begin, @to.begin, 0)
    sizes = Hash.new(0)
    @from.each_with_index do |item, from|
      _sizes = Hash.new(0)
      @to.indexes[item].each do |to|
        next if to < @to.begin
        break if to > @to.end
        size = _sizes[to] = sizes[to - 1] + 1
        match = Lookout::Diff::Match.new(from - size + 1, to - size + 1, size) if size > match.size
      end unless junk[item]
      sizes = _sizes
    end
    match
  end

  def expand(match, junking)
    from, to, size = match.from, match.to, match.size

    while from > @from.begin and to > @to.begin and
          junk[@to[to - 1]] ^ !junking and
          @from[from - 1] == @to[to - 1]
      from -= 1
      to -= 1
      size += 1
    end

    while from + size < @from.end and to + size < @to.end and
          junk[@to[to + size]] ^ !junking and
          @from[from + size] == @to[to + size]
      size += 1
    end

    Lookout::Diff::Match.new(from, to, size)
  end
end
