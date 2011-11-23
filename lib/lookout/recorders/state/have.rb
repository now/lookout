# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Have < Lookout::Recorders::State
  def initialize(subject)
    super
    @error = 'expected %p to have %s'
  end
end
