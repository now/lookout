# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Not::Have < Lookout::Recorders::State::Not
  def initialize(subject)
    super
    @error = 'expected %p not to have %s'
  end
end
