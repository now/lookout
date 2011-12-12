# -*- coding: utf-8 -*-

class Lookout::Diff::Operation
  def initialize(from, to)
    @from, @to = from, to
  end

  def foldable?(window)
    false
  end

  def >>(size)
    self
  end

  def <<(size)
    self
  end

  def parity?
    false
  end

  def ==(other)
    self.class == other.class and from == other.from and to == other.to
  end

  def inspect
    '#<%s %p,%p>' % [self.class, from, to]
  end

  attr_reader :from, :to
end
