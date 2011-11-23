# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Not < Lookout::Recorders::State
  def initialize(subject, *args)
    super
    @error = 'expected %p not to %s'
  end

  def verify
    @methods.play_for(@subject) and
      raise Error, @error % [@subject, @description.join(' ')]
    self
  end
end
