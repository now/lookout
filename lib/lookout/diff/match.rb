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
    from.touches? other.from and to.touches? other.to
  end

  def <=>(other)
    return nil unless self.class == other.class
    (from <=> other.from).nonzero? or
      (to <=> other.to).nonzero? or
      0
  end

  alias eql? ==

  def inspect
    '#<%s %p==%p>' % [self.class, from, to]
  end

  def at(from, to)
    self.class.new(self.from.at(from), self.to.at(to))
  end

  attr_reader :from, :to
end
