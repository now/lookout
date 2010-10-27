# -*- coding: utf-8 -*-

class Lookout::Diff::Match
  include Comparable

  def initialize(from, to, size)
    @from, @to, @size = from, to, size
  end

  def <=>(other)
    [from <=> other.from,
     to <=> other.to,
     size <=> other.size].find{ |d| d.nonzero? } or 0
  end

  attr_reader :from, :to, :size

  def empty?
    size.zero?
  end

  def +(other)
    self.class.new(from, to, size + other.size)
  end

  def touches?(other)
    from + size == other.from and to + size == other.to
  end

  def inspect
    '%s.new(%d, %d, %d)' % [self.class, from, to, size]
  end
end
