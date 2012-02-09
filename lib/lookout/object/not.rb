# -*- coding: utf-8 -*-

class Lookout::Object::Not < Lookout::Aphonic
  def initialize(subject)
    @subject = subject
  end

  def to
    self
  end

  def receive
    Lookout::Object::Not::Receive.new(@subject)
  end
end
