# -*- coding: utf-8 -*-

# Matching pair of {Slice}s of the sequences being “diffed”.
class Lookout::Diff::Match
  # Initializes a match between _old_ and _new_.
  # @param [Slice] old The slice of the old sequence
  # @param [Slice] new The slice of the new sequence
  Value(:old, :new)
  public :old, :new
  include Comparable

  # @return True if the matching sequences are empty
  def empty?
    old.empty?
  end

  # @return [Integer] The number of matching elements
  def size
    old.size
  end

  # @param [Match] other
  # @return [Match] A new match {Slice#+ encompassing} the slices of the
  #   receiver and _other_
  # @note Logically, the receiver should {#touch?} _other_, but this isn’t
  #   enforced.
  def +(other)
    self.class.new(old + other.old, new + other.new)
  end

  # @param [Match] other
  # @return True if {#old} and {#new} {Slice#touch? #touch?} those of _other_
  def touch?(other)
    old.touch? other.old and new.touch? other.new
  end

  # @param [Match] other
  # @return [Integer, nil] The comparison of the receiver’s {#old} and {#new}
  #   against those of _other_
  def <=>(other)
    return nil unless self.class == other.class
    (old <=> other.old).nonzero? or
      (new <=> other.new).nonzero? or
      0
  end

  alias eql? ==

  def inspect
    '#<%s %p==%p>' % [self.class, old, new]
  end

  # @param [Range] old
  # @param [Range] new
  # @return [Match] A new match with {#old} and {#new} {Slice#at #at} _old_
  #   and _new_
  def at(old, new)
    self.class.new(self.old.at(old), self.new.at(new))
  end
end
