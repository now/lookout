# -*- coding: utf-8 -*-

# Base class for operations describing the changes to perform to get from the
# original sequence to the new sequence in a “diff”.
#
# Subclasses must implement #apply that’s used in a double dispatch for
# enumerating operations, see, for example, {Operations::Copy#apply}.
class Lookout::Diff::Operation
  # @param [Range] from The range of the original sequence
  # @param [Range] to The range of the new sequence
  def initialize(from, to)
    @from, @to = from, to
  end

  # @param [Integer] window
  # @return [Boolean] True if the receiver represents an operation that is
  #   uninteresting to the actual “diff” and can be meaningfully folded inside
  #   _window_, that is, is larger than _window_
  def foldable?(window)
    false
  end

  # Folds from the beginning of the receiver, leaving _size_ elements.
  # @param [Integer] size
  # @return [self]
  # @note Logically, the receiver should be {#foldable?} inside _size_ * 2, but
  #   this isn’t enforced.
  def >>(size)
    self
  end

  # Folds from the end of the receiver, leaving _size_ elements.
  # @param [Integer] size
  # @return [self]
  # @note Logically, the receiver should be {#foldable?} inside _size_ * 2, but
  #   this isn’t enforced.
  def <<(size)
    self
  end

  # @return [Boolean] True if the receiver represents parity
  def parity?
    false
  end

  # @param [Operation] other
  # @return [Boolean] True if the receiver’s class, {#from} and {#to} `#==`
  #   those of _other_
  def ==(other)
    self.class == other.class and from == other.from and to == other.to
  end

  def inspect
    '#<%s %p,%p>' % [self.class, from, to]
  end

  # @return [Range] The range of the original sequence
  attr_reader :from

  # @return [Range] The range of the new sequence
  attr_reader :to
end
