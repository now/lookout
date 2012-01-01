# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::Output < Lookout::Expected::Object
  def actualize(file, line, &block)
    Lookout::Expect::Lookout::Output.new(self, file, line, &block)
  end

  def diff(other)
    subject.diff(other)
  end
end
