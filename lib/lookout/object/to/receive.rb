# -*- coding: utf-8 -*-

class Lookout::Object::To::Receive < Lookout::Aphonic
  def initialize(subject, negated)
    @subject, @negated = subject, negated
  end

  def method_missing(method, *args, &body)
    Lookout::Recorders::Reception.new(@subject, @negated, method, *args, &body)
  end
end
