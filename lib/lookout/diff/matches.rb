# -*- coding: utf-8 -*-

class Lookout::Diff::Matches
  autoload :From, 'lookout/diff/matches/from'
  autoload :Position, 'lookout/diff/matches/position'
  autoload :To, 'lookout/diff/matches/to'

  include Enumerable

  def initialize(from, to, &is_junk)
    @from, @to, @is_junk = from, to, is_junk
  end

  def each
    matches.each do |match|
      yield match
    end
    self
  end

private

  def matches
    return @matches if defined? @matches
    matches = []
    queue = [Position.origin(@from, @to, &@is_junk)]
    until queue.empty?
      position = queue.pop
      match = position.match
      next if match.empty?
      queue.push position.end_at(match) if position.begins_before? match
      matches << match
      queue.push position.begin_at(match) if position.ends_after? match
    end
    @matches = matches.sort
  end
end
