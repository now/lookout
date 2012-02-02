# -*- coding: utf-8 -*-

class Lookout::Expected::Module < Lookout::Expected::Object
  def =~(other)
    subject === other or subject == other
  end

  def difference(other)
    self =~ other ? nil : Lookout::Difference::Module.new(other, subject)
  end
end
