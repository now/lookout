# -*- coding: utf-8 -*-

class Lookout::Expected::Range < Lookout::Expected::Object
  def =~(other)
    subject === other or subject == other
  end

  def difference(other)
    self =~ other ? nil : Lookout::Difference::Range.new(other, subject)
  end
end
