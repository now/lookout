# -*- coding: utf-8 -*-

class Lookout::Object::To < Lookout::Aphonic
  def initialize(subject)
    @subject = subject
  end

  def receive
    Lookout::Object::To::Receive.new(@subject)
  end
end
