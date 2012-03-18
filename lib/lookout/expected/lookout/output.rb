# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::Output < Lookout::Expected::Object
  def expect(file, line, &block)
    Lookout::Expect::Lookout::Output.new(self, file, line, &block)
  end

  def difference(other)
    Lookout::Difference::Lookout::Output.new(other, subject) unless
      subject == other
  end
end
