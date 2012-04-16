# -*- coding: utf-8 -*-

# Slice that should be copied from the old sequence.
class Lookout::Diff::Operations::Copy < Lookout::Diff::Operation
  # @param [Integer] window
  # @return [Boolean] True if the slice of the old sequence is larger than
  #   _window_ ({#old}{Slice#size #size} > _window_)
  def foldable?(window)
    old.size > window
  end

  # (see Operation#>>)
  def >>(size)
    self.class.new(old.begin_at([old.begin, old.end - size + 1].max),
                   new.begin_at([new.begin, new.end - size + 1].max))
  end

  # (see Operation#<<)
  def <<(size)
    self.class.new(old.end_at([old.end, old.begin + size - 1].min),
                   new.end_at([new.end, new.begin + size - 1].min))
  end

  # @return [Boolean] True if {#old} `#==` {#new}
  def parity?
    old == new
  end
end
