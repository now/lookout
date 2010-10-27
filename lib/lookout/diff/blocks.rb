# -*- coding: utf-8 -*-

# TODO: This folds consecutive matches.  This should be called something
# else, like Fold.
class Lookout::Diff::Blocks
  include Enumerable

  class << self
    def diff(from, to, &is_junk)
      new(from.size, to.size, Lookout::Diff::Algorithm::Difflib.new(from, to, &is_junk))
    end
  end

  # TODO: Need access to the sizes.  Is this avoidable?
  def initialize(from_size, to_size, matches)
    @from_size, @to_size, @matches = from_size, to_size, matches
  end

  def each
    blocks.each do |block|
      yield block
    end
    self
  end

private

  # TODO: No need to build this and not yield.  I mean, sure, we can cache the
  # result, but that’s just silly.
  def blocks
    return @blocks if defined? @blocks
    blocks = []
    current = Lookout::Diff::Match.new(0, 0, 0)
    @matches.each do |match|
      if current.touches? match
         current += match
      else
        blocks << current unless current.empty?
        current = match
      end
    end
    blocks << current unless current.empty?
    blocks << Lookout::Diff::Match.new(@from_size, @to_size, 0)
    @blocks = blocks
  end
end
