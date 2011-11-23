# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Not::Verify < Lookout::Recorders::State::Verify
  def call
    play and error
    true
  end

  private

  def format
    @error = 'expected %p not to %s'
  end
end
