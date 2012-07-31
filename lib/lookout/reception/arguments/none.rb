# -*- coding: utf-8 -*-

# Arguments matcher matching an empty list of arguments.
class Lookout::Reception::Arguments::None < Lookout::Reception::Arguments::List
  def initialize; super end

  # @return [Object, Array<Object>] The receiver as an array
  def to_a; [self] end
end
