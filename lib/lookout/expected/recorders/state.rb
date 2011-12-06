# -*- coding: utf-8 -*-

class Lookout::Expected::Recorders::State < Lookout::Expected::Object
  def initialize(subject, verify)
    @subject, @verify = subject, verify
  end

  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Recorders::State.new(self, file, line, &block)
  end

  def subject
    @subject
  end

  def verify
    @verify.call
  end
end
