# -*- coding: utf-8 -*-

class Lookout::Diff::Algorithms::Difflib
  autoload :Position, 'lookout/diff/algorithms/difflib/position'

  include Enumerable

  def initialize(from, to, &is_junk)
    @from, @to, @is_junk = from, to, is_junk
  end

  def each
    current = Lookout::Diff::Match.new(Lookout::Diff::Range.new(@from, 0...0),
                                       Lookout::Diff::Range.new(@to, 0...0))
    stack = [Position.origin(@from, @to, &@is_junk)]
    until stack.empty?
      case item = stack.pop
      when Position
        match = item.match
        next if match.empty?
        stack.push item.begin_after(match) if item.ends_after? match
        stack.push match
        stack.push item.end_before(match) if item.begins_before? match
      when Lookout::Diff::Match
        if current.touches? item
          current += item
        else
          yield current unless current.empty?
          current = item
        end
      end
    end
    yield current unless current.empty?
    yield Lookout::Diff::Match.new(current.from.at(@from.size...@from.size),
                                   current.to.at(@to.size...@to.size))
    self
  end
end
