# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Be < Lookout::Recorders::State
  def initialize(subject, negated)
    super
    @error = @negated ? 'expected %p not to be %s' : 'expected %p to be %s'
  end
end
