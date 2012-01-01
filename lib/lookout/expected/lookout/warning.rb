# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::Warning < Lookout::Expected::Lookout::Output
  def actualize(file, line, &block)
    Lookout::Expect::Lookout::Warning.new(self, file, line, &block)
  end

  def =~(other)
    subject === other or subject == other
  end
end
