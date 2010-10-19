# -*- coding: utf-8 -*-

class Object
  def to
    Lookout::Recorder.new(self)
  end

  def not
    Lookout::Recorder::Not.new(self)
  end
end
