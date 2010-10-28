# -*- coding: utf-8 -*-

class Lookout::Diff::Operations::Equal
  include Lookout::Diff::Operation

  def foldable?(window)
    @from.end - @from.begin > window
  end

  def >>(size)
    self.class.new([from.begin, from.end - size].max...from.end,
                   [to.begin, to.end - size].max...to.end)
  end

  def <<(size)
    self.class.new(from.begin...[from.end, from.begin + size].min,
                   to.begin...[to.end, to.begin + size].min)
  end

  def apply(object)
    object.equal(self)
  end
end
