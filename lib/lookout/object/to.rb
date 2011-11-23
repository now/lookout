# -*- coding: utf-8 -*-

class Lookout::Object::To < Lookout::Aphonic
  def initialize(subject, negated = false)
    @subject, @negated = subject, negated
  end

  def receive
    Lookout::Object::To::Receive.new(@subject, @negated)
  end

  def be
    # TODO: Make real objects of Be and Have.
    Lookout::Recorders::State.new(@subject, @negated, :be)
  end

  def have
    Lookout::Recorders::State.new(@subject, @negated, :have)
  end

  def method_missing(method, *args)
    return super unless method.to_s =~ /\?$/
    Lookout::Recorders::State.new(@subject, @negated, nil, method, *args)
  end
end
