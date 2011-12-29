# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::List
  def initialize(*args)
    @args = args
  end

  def =~(other)
    args.to_lookout_expected =~ other
  end

  def ==(other)
    self.class == other.class and
      args == other.args
  end

  alias eql? ==

  def hash
    self.class.hash ^ args.hash
  end

  def inspect
    Lookout::Inspect::Argument.list(args)
  end

  def to_a
    args.to_a
  end

  protected

  attr_reader :args
end
