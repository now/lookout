# -*- coding: utf-8 -*-

# Represents a slice that should be copied from the original sequence.
class Lookout::Diff::Operations::Copy < Lookout::Diff::Operation
  # @param [Integer] window
  # @return [Boolean] True if the slice of the original sequence is larger than
  #   _window_ ({#from}{Range#size #size} > _window_)
  def foldable?(window)
    from.size > window
  end

  # (see Operation#>>)
  def >>(size)
    self.class.new(from.begin_at([from.begin, from.end - size + 1].max),
                   to.begin_at([to.begin, to.end - size + 1].max))
  end

  # (see Operation#<<)
  def <<(size)
    self.class.new(from.end_at([from.end, from.begin + size - 1].min),
                   to.end_at([to.end, to.begin + size - 1].min))
  end

  # @return [Boolean] True if {#from} `#==` {#to}
  def parity?
    from == to
  end
end
