# -*- coding: utf-8 -*-

class Lookout::Diff::Groups
  include Enumerable

  def initialize(operations, context = 3)
    @operations, @context = operations, context
  end

  def each
    saved = nil
    group = Lookout::Diff::Group.new
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
        group = Lookout::Diff::Group.new(operation >> @context)
      else
        group << operation
      end
    end
    if saved
      yield saved
    elsif not group.empty?
      yield group.fold(@context)
    end
  end
end
