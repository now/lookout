# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::Warning < Lookout::Expected::Lookout::Output
  def expect(file, line, &block)
    Lookout::Expect::Lookout::Warning.new(self, file, line, &block)
  end

  def difference(other)
    Lookout::Difference::Lookout::Warning.new(other, subject) unless
      subject === other or
      subject == other
  end
end
