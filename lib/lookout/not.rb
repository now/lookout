# -*- coding: utf-8 -*-

class Lookout::Not < Lookout::Aphonic
  def initialize(subject)
    @subject = subject
  end

  def to
    @subject.to.not
  end
end
