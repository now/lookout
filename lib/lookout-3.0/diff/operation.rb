# -*- coding: utf-8 -*-

# Base class for operations describing the changes to perform to get from the
# old version of a sequence to the new in a “diff”.
class Lookout::Diff::Operation
  # Initializes the operation with the slices of the OLD and NEW sequences.
  # @param [Slice] old The slice of the old sequence
  # @param [Slice] new The slice of the new sequence
  Value(:old, :new)
  public :old, :new

  # @param [Integer] context
  # @return True if the operation is uninteresting to the actual “diff” and can
  #   be meaningfully folded, leaving CONTEXT elements
  # @see Operations::Copy#foldable?
  def foldable?(context) false end

  # Folds from the beginning of the receiver, leaving CONTEXT elements.
  # @param [Integer] context
  # @note Logically, the receiver should be {#foldable?} inside CONTEXT, but
  #   this isn’t enforced.
  def >>(context) self end

  # Folds from the end of the receiver, leaving CONTEXT elements.
  # @param [Integer] context
  # @note Logically, the receiver should be {#foldable?} inside CONTEXT, but
  #   this isn’t enforced.
  def <<(context) self end

  # @return True if the receiver represents parity
  # @see Operations::Copy#parity?
  def parity?; false end

  # Implements a double dispatch for enumerating operations, where OBJECT is
  # sent the last part of the receiver’s class’ name with the receiver as the
  # lone argument.
  # @return The result of OBJECT#name(self)
  def apply(object)
    object.send(@apply ||= self.class.name.split('::').last.downcase.to_sym, self)
  end
end
