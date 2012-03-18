# -*- coding: utf-8 -*-

class Lookout::Expected::Module < Lookout::Expected::Object
  def difference(other)
    Lookout::Difference::Module.new(other, subject) unless
      subject == other or
      subject === other
  end
end
