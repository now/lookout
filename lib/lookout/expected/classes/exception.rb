# -*- coding: utf-8 -*-

class Lookout::Expected::Classes::Exception < Lookout::Expected::Object
  def expect(file, line, &block)
    Lookout::Expect::Classes::Exception.new(self, file, line, &block)
  end
end
