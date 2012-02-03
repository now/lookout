# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::Output < Lookout::Expected::Object
  def expect(file, line, &block)
    Lookout::Expect::Lookout::Output.new(self, file, line, &block)
  end

  def difference(other)
    self =~ other ? nil : Lookout::Difference::Lookout::Output.new(other, subject)
  end
end
