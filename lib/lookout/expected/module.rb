# -*- coding: utf-8 -*-

class Lookout::Expected::Module < Lookout::Expected::Object
  def =~(other)
    @expected === other or @expected == other
  end
end
