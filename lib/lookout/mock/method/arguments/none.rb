# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::None
  def ==(other)
    other.empty?
  end

  def inspect
    ''
  end
end
