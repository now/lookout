# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::Any
  def =~(other)
    true
  end

  def inspect
    '*args, &block'
  end

  def to_a
    [self]
  end
end
