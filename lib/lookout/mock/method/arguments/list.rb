# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::List
  def initialize(*args)
    @args = args
  end

  def ==(other)
    Lookout::Equality.equal?(@args, other)
  end

  def inspect
    @args.map{ |arg| Lookout::Inspect.new(arg, 'argument').call }.join(', ')
  end
end
