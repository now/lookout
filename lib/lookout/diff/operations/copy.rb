# -*- coding: utf-8 -*-

# Slice that should be copied from the old sequence.
class Lookout::Diff::Operations::Copy < Lookout::Diff::Operation
  # @param [Integer] context
  # @return True if the slice of the old sequence is larger than _context_ * 2
  #   ({#old}{Slice#size #size} > _context_ * 2) so that it may be folded to
  #   _context_ at both ends ({#>>}, {#<<})
  def foldable?(context) old.size > context * 2 end

  # (see Operation#>>)
  def >>(context)
    self.class.new(old.begin_at([old.begin, old.end - context + 1].max),
                   new.begin_at([new.begin, new.end - context + 1].max))
  end

  # (see Operation#<<)
  def <<(context)
    self.class.new(old.end_at([old.end, old.begin + context - 1].min),
                   new.end_at([new.end, new.begin + context - 1].min))
  end

  # @return True if {#old} `#==` {#new}
  def parity?; old == new end
end
