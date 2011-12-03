# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::List
  def initialize(*args)
    @args = args
  end

  def ==(other)
    Lookout::Equality.equal?(@args, other)
  end

  def inspect
    Lookout::Inspect::Argument.list(@args)
  end
end
