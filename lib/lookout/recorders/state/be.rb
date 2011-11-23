# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Be < Lookout::Recorders::State
  def initialize(subject)
    super
    @error = 'expected %p to be %s'
  end
end
