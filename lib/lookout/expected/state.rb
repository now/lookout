# -*- coding: utf-8 -*-

class Lookout::Expected::State < Lookout::Expected::Object
  def initialize(subject, verify)
    super subject
    @verify = verify
  end

  def actualize(file, line, &block)
    Lookout::Expect::State.new(self, file, line, &block)
  end

  def verify
    @verify.call
  end
end
