# -*- coding: utf-8 -*-

class Lookout::Object::To < Lookout::Aphonic
  def initialize(subject)
    @subject = subject
  end

  def receive
    Lookout::Object::To::Receive.new(@subject)
  end

  def be
    Lookout::Recorders::State::Be.new(@subject)
  end

  def have
    Lookout::Recorders::State::Have.new(@subject)
  end

  private

  def method_missing(method, *args)
    return super unless method.to_s =~ /\?$/
    Lookout::Recorders::State.new(@subject, method, *args)
  end
end
