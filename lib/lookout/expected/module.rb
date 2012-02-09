# -*- coding: utf-8 -*-

class Lookout::Expected::Module < Lookout::Expected::Object
  def difference(other)
    (subject == other or subject === other) ?
      nil :
      Lookout::Difference::Module.new(other, subject)
  end
end
