# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::Warning < Lookout::Expected::Lookout::Output
  def expect(file, line, &block)
    Lookout::Expect::Lookout::Warning.new(self, file, line, &block)
  end

  def =~(other)
    subject === other or subject == other
  end

  def difference(other)
    self =~ other ? nil : Lookout::Difference::Lookout::Warning.new(other, subject)
  end
end
