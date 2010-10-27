# -*- coding: utf-8 -*-

class Lookout::Diff::Operations
  autoload :Delete, 'lookout/diff/operations/delete'
  autoload :Equal, 'lookout/diff/operations/equal'
  autoload :Insert, 'lookout/diff/operations/insert'
  autoload :Replace, 'lookout/diff/operations/replace'

  include Enumerable

  class << self
    def diff(from, to, &is_junk)
      new(Lookout::Diff::Blocks.diff(from, to, &is_junk))
    end
  end

  def initialize(matches)
    @matches = matches
  end

  def each
    operations.each do |operation|
      yield operation
    end
    self
  end

  def same?
    return false if operations.size != 1
    operation = operations.first
    operation.is_a? Equal and operation.from == operation.to
  end

private

  def operations
    return @operations if defined? @operations
    operations = []
    from = to = 0
    @matches.each do |match|
      type = typeify(from, to, match)
      operations << type.new(from...match.from, to...match.to) if type != Equal
      from, to = match.from + match.size, match.to + match.size
      operations << Equal.new(match.from...from, match.to...to) unless match.empty?
    end
    @operations = operations
  end

  def typeify(from, to, match)
    if    from < match.from and to < match.to then Replace
    elsif from < match.from                   then Delete
    elsif to < match.to                       then Insert
    else                                           Equal
    end
  end
end