# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::Any
  def ==(other)
    true
  end

  def to_s
    '*args, &block'
  end
end
