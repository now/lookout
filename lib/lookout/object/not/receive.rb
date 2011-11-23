# -*- coding: utf-8 -*-

class Lookout::Object::Not::Receive < Lookout::Aphonic
  def initialize(subject)
    @subject = subject
  end

  private

  def method_missing(method, *args, &body)
    Lookout::Recorders::Reception::Not.new(@subject, method, *args, &body)
  end
end
