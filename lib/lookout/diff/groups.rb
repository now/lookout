# -*- coding: utf-8 -*-

class Lookout::Diff::Groups
  include Enumerable

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
    if saved
      yield saved
    elsif not group.empty?
      group[-1] = group[-1] << @context
      yield group
    end
  end
end
