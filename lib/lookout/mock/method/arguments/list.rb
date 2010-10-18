# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::List
  def initialize(args)
    # TODO: Look for any regexes to match against
    @args = args
  end

  def ==(other)
    @args == other
  end

  def to_s
    @args.map(&:to_s).join(', ')
  end
end
