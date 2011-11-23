# -*- coding: utf-8 -*-

class Lookout::Object::To < Lookout::Aphonic
  def initialize(subject, negated = false)
    @subject, @negated = subject, negated
  end

  def receive
    Lookout::Object::To::Receive.new(@subject, @negated)
  end

  def be
    Lookout::Recorders::State::Be.new(@subject, @negated)
  end

  def have
    Lookout::Recorders::State::Have.new(@subject, @negated)
  end

  def method_missing(method, *args)
    return super unless method.to_s =~ /\?$/
    Lookout::Recorders::State.new(@subject, @negated, method, *args)
  end
end
