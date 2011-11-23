# -*- coding: utf-8 -*-

class Lookout::Object::Not < Lookout::Aphonic
  def initialize(subject)
    @subject = subject
  end

  def to
    Lookout::Object::To.new(@subject, true)
  end
end
