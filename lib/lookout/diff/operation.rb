# -*- coding: utf-8 -*-

module Lookout::Diff::Operation
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
    from == other.from and to == other.to
  end

  def inspect
    '%s.new(%p, %p)' % [self.class, from, to]
  end

  attr_reader :from, :to
end
