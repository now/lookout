# -*- coding: utf-8 -*-

# Arguments matcher matching an empty list of arguments.
class Lookout::Mock::Method::Arguments::None < Lookout::Mock::Method::Arguments::List
  def initialize
    super
  end

  # @return [Object, Array<Object>] self as an array
  def to_a
    [self]
  end
end
