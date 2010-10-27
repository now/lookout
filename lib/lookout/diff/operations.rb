# -*- coding: utf-8 -*-

class Lookout::Diff::Operations
  autoload :Delete, 'lookout/diff/operations/delete'
  autoload :Equal, 'lookout/diff/operations/equal'
  autoload :Insert, 'lookout/diff/operations/insert'
  autoload :Replace, 'lookout/diff/operations/replace'

  include Enumerable

  class << self
    def diff(from, to, &is_junk)
      new(Lookout::Diff::Algorithm::Difflib.new(from, to, &is_junk))
    end
  end

  def initialize(matches)
    @matches = matches
  end

  def each
    from = to = 0
    @matches.each do |match|
      type = typeify(from, to, match)
      yield type.new(from...match.from, to...match.to) unless type == Equal
      from, to = match.from + match.size, match.to + match.size
      yield Equal.new(match.from...from, match.to...to) unless match.empty?
    end
    self
  end

private

  def typeify(from, to, match)
    if    from < match.from and to < match.to then Replace
    elsif from < match.from                   then Delete
    elsif to < match.to                       then Insert
    else                                           Equal
    end
  end
end
