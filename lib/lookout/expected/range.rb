# -*- coding: utf-8 -*-

class Lookout::Expected::Range < Lookout::Expected::Object
  def =~(other)
    subject === other or subject == other
  end
end
