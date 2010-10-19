# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::Anything
  def ==(other)
    true
  end

  def inspect
    'arg'
  end
end
