# -*- coding: utf-8 -*-

# Matching pair of {Slice}s of the sequences being “diffed”.
class Lookout::Diff::Match
  # Initializes a match between _old_ and _new_.
  # @param [Slice] old The slice of the old sequence
  # @param [Slice] new The slice of the new sequence
  Value(:old, :new, :comparable => true)
  public :old, :new

  # @return True if the matching sequences are empty
  def empty?; old.empty? end

  # @return The number of matching elements
  def size; old.size end

  # @return A new match {Slice#+ encompassing} the slices of the
  #   receiver and _other_
  # @note Logically, the receiver should {#touch?} _other_, but this isn’t
  #   enforced.
  def +(other) self.class.new(old + other.old, new + other.new) end

  # @return True if {#old} and {#new} {Slice#touch? #touch?} those of _other_
  def touch?(other) old.touch? other.old and new.touch? other.new end

  # @param [Range] old
  # @param [Range] new
  # @return [Match] A new match with {#old} and {#new} {Slice#at #at} _old_
  #   and _new_
  def at(old, new) self.class.new(self.old.at(old), self.new.at(new)) end
end
