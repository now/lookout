# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::Warning < Lookout::Expected::Lookout::Output
  def expect(file, line, &block)
    Lookout::Expect::Lookout::Warning.new(self, file, line, &block)
  end

  def difference(other)
    (subject === other or subject == other) ?
      nil :
      Lookout::Difference::Lookout::Warning.new(other, subject)
  end
end
