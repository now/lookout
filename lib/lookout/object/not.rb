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
    Lookout::State::Not::Be.new(@subject)
  end

  def have
    Lookout::State::Not::Have.new(@subject)
  end

  private

  def method_missing(method, *args)
    return super unless method.to_s =~ /\?\z/
    Lookout::State::Not.new(@subject, method, *args)
  end
end
