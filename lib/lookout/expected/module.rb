# -*- coding: utf-8 -*-

class Lookout::Expected::Module < Lookout::Expected::Object
  def =~(other)
    subject === other or subject == other
  end
end
