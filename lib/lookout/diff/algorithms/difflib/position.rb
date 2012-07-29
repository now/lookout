# -*- coding: utf-8 -*-

# Keeps track of a position into the two sequences currently being “diffed” of
# the difflib algorithm and generates matches and new positions based on this
# position.
#
# @private
class Lookout::Diff::Algorithms::Difflib::Position
  Value(:old, :new, :junk)

  class << self
    def origin(old, new)
      new = New.new(new)
      new(Lookout::Diff::Slice.new(old),
          new,
          block_given? ? new.indexes.reduce({}){ |j, (k, _)| j[k] = yield(k); j } : {})
    end
  end

  def match; junk.empty? ? leftmost_longest : expand(expand(leftmost_longest, false), true) end
  def begin_before?(match) old.begin_before? match.old and new.begin_before? match.new end
  def end_after?(match) old.end_after? match.old and new.end_after? match.new end
  def begin_after(match) self.class.new(old.begin_after(match.old), new.begin_after(match.new), junk) end
  def end_before(match) self.class.new(old.end_before(match.old), new.end_before(match.new), junk) end
  def inspect; '#<%s %p,%p>' % [self.class, old, new] end

  private

  def leftmost_longest
    match = Lookout::Diff::Match.new(@old.at(0...0), @new.at(0...0))
    sizes = Hash.new(0)
    @old.each_with_index do |item, old|
      _sizes = Hash.new(0)
      @new.each_index(item) do |new|
        size = _sizes[new] = sizes[new - 1] + 1
        match = match.at(old - size + 1..old,
                         new - size + 1..new) if size > match.size
      end unless junk[item]
      sizes = _sizes
    end
    match
  end

  def expand(match, junking)
    old_begin, new_begin = match.old.begin, match.new.begin
    while old_begin > old.begin and new_begin > new.begin and
          junk[new[new_begin - 1]] ^ !junking and
          old[old_begin - 1] == new[new_begin - 1]
      old_begin -= 1
      new_begin -= 1
    end

    old_end, new_end = match.old.end, match.new.end
    while old_end + 1 <= old.end and new_end + 1 <= new.end and
          junk[new[new_end + 1]] ^ !junking and
          old[old_end + 1] == new[new_end + 1]
      old_end += 1
      new_end += 1
    end

    match.at(old_begin..old_end, new_begin..new_end)
  end
end
