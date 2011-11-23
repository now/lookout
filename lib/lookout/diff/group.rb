# -*- coding: utf-8 -*-

class Lookout::Diff::Group
  include Enumerable

  def initialize(*operations)
    @operations = operations
  end

  def empty?
    operations.empty?
  end

  def <<(operation)
    operations << operation
    self
  end

  def fold(context)
    operations[-1] = operations[-1] << context
    self
  end

  def parity?
    operations.size == 1 and operations.first.parity?
  end

  def each
    operations.each do |operation|
      yield operation
    end
    self
  end

  def from
    range(:from)
  end

  def to
    range(:to)
  end

  def ==(other)
    operations == other.operations
  end

  def inspect
    '<#%s %p>' % [self.class, operations]
  end

  protected

  attr_reader :operations

  private

  def range(target)
    operations.first.send(target).
      at(operations.first.send(target).begin..operations.last.send(target).end)
  end
end
