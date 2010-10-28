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
    saved = nil
    group = []
    @operations.each do |operation|
      if saved
        yield saved
        saved = nil
      end
      if group.empty?
        operation = operation >> @context
        group << operation
      elsif operation.foldable? @context * 2
        saved = group << (operation << @context)
        group = [operation >> @context]
      else
        group << operation
      end
    end
    if group.empty?
      yield [Lookout::Diff::Operations::Equal.new(0...0, 0...0)]
    elsif saved
      yield saved
    else
      group[-1] = group[-1] << @context
      yield group
    end
  end
end
