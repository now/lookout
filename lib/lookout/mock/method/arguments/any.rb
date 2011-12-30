# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::Any
  def =~(other)
    true
  end

  def ==(other)
    self.class == other.class
  end

  alias eql? ==

  def hash
    self.class.hash
  end

  def to_s
    '*args, &block'
  end

  def to_a
    [self]
  end
end
