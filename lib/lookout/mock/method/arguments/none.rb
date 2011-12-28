# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Arguments::None < Lookout::Mock::Method::Arguments::List
  def initialize
    super
  end

  def to_a
    [self]
  end
end
