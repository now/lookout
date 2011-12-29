# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::Any
  def =~(other)
    true
  end

  def ==(other)
    self.class == other.class
  end

  alias eql? ==

  # TODO: How do we implement #hash?

  def inspect
    '*args, &block'
  end

  def to_a
    [self]
  end
end
