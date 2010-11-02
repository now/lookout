# -*- coding: utf-8 -*-

class Lookout::Diff::Operations
  autoload :Delete, 'lookout/diff/operations/delete'
  autoload :Equal, 'lookout/diff/operations/equal'
  autoload :Insert, 'lookout/diff/operations/insert'
  autoload :Replace, 'lookout/diff/operations/replace'

  include Enumerable

  def initialize(matches)
    @matches = matches
  end

  def each
    from = to = 0
    @matches.each do |match|
      type = typeify(from, to, match)
      yield type.new(match.from.at(from...match.from.begin),
                     match.to.at(to...match.to.begin)) unless type == Equal
      yield Equal.new(match.from, match.to) unless match.empty?
      from, to = match.from.end + 1, match.to.end + 1
    end
    self
  end

private

  def typeify(from, to, match)
    if    from < match.from.begin and to < match.to.begin then Replace
    elsif from < match.from.begin                         then Delete
    elsif to < match.to.begin                             then Insert
    else                                                       Equal
    end
  end
end
