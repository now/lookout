# -*- coding: utf-8 -*-

class Lookout::Object::Not::Receive < Lookout::Aphonic
  def initialize(subject)
    @subject = subject
  end

  private

  def method_missing(method, *args, &body)
    Lookout::Reception.new(@subject, method, *args, &body).never
  end
end
