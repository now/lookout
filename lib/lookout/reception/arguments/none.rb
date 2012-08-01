# -*- coding: utf-8 -*-

# Arguments matcher matching an empty list of arguments.
class Lookout::Reception::Arguments::None < Lookout::Reception::Arguments::List
  def initialize; super end
end
