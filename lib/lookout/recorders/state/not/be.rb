# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Not::Be < Lookout::Recorders::State::Not
  def initialize(subject)
    super
    @error = 'expected %p not to be %s'
  end
end
