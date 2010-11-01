# -*- coding: utf-8 -*-

class Lookout::Diff::Match
  include Comparable

  def initialize(from, to)
    @from, @to = from, to
  end

  def empty?
    from.empty?
  end

  def size
    from.size
  end

  def +(other)
    self.class.new(from + other.from, to + other.to)
  end

  def touches?(other)
    from.end + 1 == other.from.begin and to.end + 1 == other.to.begin
  end

  def <=>(other)
    [from.begin <=> other.from.begin,
     from.end <=> other.from.end,
     to.begin <=> other.to.begin,
     to.end <=> other.to.end].find{ |d| d.nonzero? } or 0
  end

  def inspect
    '#<%s %p==%p>' % [self.class, from, to]
  end

  attr_reader :from, :to
end
