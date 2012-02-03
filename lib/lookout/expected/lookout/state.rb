# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::State < Lookout::Expected::Object
  def initialize(subject, verify)
    super subject
    @verify = verify
  end

  def expect(file, line, &block)
    Lookout::Expect::Lookout::State.new(self, file, line, &block)
  end

  def verify
    @verify.call
  end
end
