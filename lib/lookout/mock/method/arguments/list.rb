# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::List
  def initialize(*args)
    @args = args
  end

  def ==(other)
    Lookout::Equality.equal?(@args, other)
  end

  def inspect
    @args.map{ |e| Lookout::Inspect::Argument.new(e).call }.join(', ')
  end
end
