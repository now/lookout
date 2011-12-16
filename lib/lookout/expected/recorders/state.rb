# -*- coding: utf-8 -*-

class Lookout::Expected::Recorders::State < Lookout::Expected::Object
  def initialize(subject, verify)
    super subject
    @verify = verify
  end

  def actualize(file, line, &block)
    Lookout::Expect::Recorders::State.new(self, file, line, &block)
  end

  def verify
    @verify.call
  end
end
