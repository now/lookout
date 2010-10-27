# -*- coding: utf-8 -*-

class Lookout::Diff::Groups
  include Enumerable

  class << self
    def diff(from, to, context = 3, &is_junk)
      new(Lookout::Diff::Operations.diff(from, to, &is_junk), context)
    end
  end

  def initialize(operations, context = 3)
    @operations, @context = operations, context
  end

  def each
    groups.each do |group|
      yield group
    end
    self
  end

  def same?
    return false if groups.size != 1
    operations = groups.first
    return false if operations.size != 1
    operation = operations.first
    operation.is_a? Lookout::Diff::Operations::Equal and operation.from == operation.to
  end

private

  def groups
    return @groups if defined? @groups
    operations = @operations.to_a
    operations = [Lookout::Diff::Operations::Equal.new(0...0, 0...0)] if operations.empty?
    expand_edge_adjustables! operations

    window = @context * 2
    groups = []
    group = []
    operations.each do |operation|
      if operation.adjustable? and operation.size > window
        group << (operation << @context)
        groups << group
        group = [operation >> @context]
      else
        group << operation
      end
    end
    groups << group unless group.empty?
    @groups = groups
  end

  def expand_edge_adjustables!(operations)
    operations[0] = operations[0] >> @context if operations[0].adjustable?
    operations[-1] = operations[-1] << @context if operations[-1].adjustable?
  end
end
