# -*- coding: utf-8 -*-

class Lookout::Recorder::Not < Lookout::Aphonic
  def initialize(subject)
    @subject = subject
  end

  def to
    @subject.to.not
  end
end
