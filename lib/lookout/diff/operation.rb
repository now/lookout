# -*- coding: utf-8 -*-

# Base class for operations describing the changes to perform to get from the
# original sequence to the new sequence in a “diff”.
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

  # @private
  def inspect
    '#<%s %p,%p>' % [self.class, from, to]
  end

  attr_reader :from, :to
end
