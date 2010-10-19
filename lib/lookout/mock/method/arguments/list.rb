# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::List
  def initialize(args)
    @args = args.map{ |arg| Lookout::Literals.equalify(arg) }
  end

  def ==(other)
    @args == other
  end

  def inspect
    @args.map{ |arg| arg.inspect }.join(', ')
  end
end
