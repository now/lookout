# -*- coding: utf-8 -*-

class Lookout::Diff::Algorithm::Difflib
  autoload :Position, 'lookout/diff/algorithm/difflib/position'

  include Enumerable

  def initialize(from, to, &is_junk)
    @from, @to, @is_junk = from, to, is_junk
  end

  def each
    stack = [Position.origin(@from, @to, &@is_junk)]
    until stack.empty?
      case item = stack.pop
      when Position
        match = item.match
        next if match.empty?
        stack.push item.begin_after(match) if item.ends_after? match
        stack.push match
        stack.push item.end_at(match) if item.begins_before? match
      when Lookout::Diff::Match
        yield item
      end
    end
    self
  end
end