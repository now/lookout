# -*- coding: utf-8 -*-

class Lookout::Expected::Regexp < Lookout::Expected::Object
  def =~(other)
    subject === other or subject == other
  end

  def difference(other)
    self =~ other ? nil : Lookout::Difference::Regexp.new(other, subject)
  end
end
