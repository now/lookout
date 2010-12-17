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
    [from.begin, from.end, to.begin, to.end] <=>
      [other.from.begin, other.from.end, other.to.begin, other.to.end]
  end

  def inspect
    '#<%s %p==%p>' % [self.class, from, to]
  end

  attr_reader :from, :to
end
