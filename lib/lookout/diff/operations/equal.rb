# -*- coding: utf-8 -*-

class Lookout::Diff::Operations::Equal < Lookout::Diff::Operation
  def foldable?(window)
    from.size > window
  end

  def >>(size)
    self.class.new(from.begin_at([from.begin, from.end - size + 1].max),
                   to.begin_at([to.begin, to.end - size + 1].max))
  end

  def <<(size)
    self.class.new(from.end_at([from.end, from.begin + size - 1].min),
                   to.end_at([to.end, to.begin + size - 1].min))
  end

  def parity?
    from == to
  end

  def apply(object)
    object.equal(self)
  end
end
