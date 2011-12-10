# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::List
  def initialize(*args)
    @args = args
  end

  def =~(other)
    @args.to_lookout_expected =~ other
  end

  def inspect
    Lookout::Inspect::Argument.list(@args)
  end
end
