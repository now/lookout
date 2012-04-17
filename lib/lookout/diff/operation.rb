# -*- coding: utf-8 -*-

# Base class for operations describing the changes to perform to get from the
# old version of a sequence to the new in a “diff”.
class Lookout::Diff::Operation
  # Initializes the operation with the slices of the _old_ and _new_ sequences.
  # @param [Slice] old
  # @param [Slice] new
  def initialize(old, new)
    @old, @new = old, new
  end

  # @param [Integer] context
  # @return [Boolean] True if the operation is uninteresting to the actual
  #   “diff” and can be meaningfully folded, leaving _context_ elements
  # @see Operations::Copy#foldable?
  def foldable?(context)
    false
  end

  # Folds from the beginning of the receiver, leaving _context_ elements.
  # @param [Integer] context
  # @return [self]
  # @note Logically, the receiver should be {#foldable?} inside _context_, but
  #   this isn’t enforced.
  def >>(context)
    self
  end

  # Folds from the end of the receiver, leaving _context_ elements.
  # @param [Integer] context
  # @return [self]
  # @note Logically, the receiver should be {#foldable?} inside _context_ , but
  #   this isn’t enforced.
  def <<(context)
    self
  end

  # @return [Boolean] True if the receiver represents parity
  # @see Operations::Copy#parity?
  def parity?
    false
  end

  # @param [Operation] other
  # @return [Boolean] True if the receiver’s class, {#old} and {#new} `#==`
  #   those of _other_
  def ==(other)
    self.class == other.class and old == other.old and new == other.new
  end

  alias eql? ==

  def hash
    @hash ||= [old, new].hash
  end

  def inspect
    '#<%s %p,%p>' % [self.class, old, new]
  end

  # @return [Slice] The slice of the original sequence
  attr_reader :old

  # @return [Slice] The slice of the new sequence
  attr_reader :new

  # Implements a double dispatch for enumerating operations, where _object_ is
  # sent the last part of the receiver’s class’ _name_ with the receiver as the
  # lone argument.
  # @param [Object] object
  # @return The result of _object_#_name_(self)
  def apply(object)
    object.send(@apply ||= self.class.name.split('::').last.downcase.to_sym, self)
  end
end
