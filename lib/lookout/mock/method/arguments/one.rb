# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::Any
  def ==(other)
    other.count == 1
  end

  def inspect
    'arg'
  end
end
