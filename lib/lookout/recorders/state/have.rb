# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Have < Lookout::Recorders::State
  def initialize(subject, negated)
    super
    @error = @negated ? 'expected %p not to have %s' : 'expected %p to have %s'
  end
end
