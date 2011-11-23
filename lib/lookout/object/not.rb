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

  def be
    Lookout::Recorders::State::Not::Be.new(@subject)
  end

  def have
    Lookout::Recorders::State::Not::Have.new(@subject)
  end

  def method_missing(method, *args)
    return super unless method.to_s =~ /\?$/
    Lookout::Recorders::State::Not.new(@subject, method, *args)
  end
end
