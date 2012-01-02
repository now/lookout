# -*- coding: utf-8 -*-

class Lookout::State::Not::Verify < Lookout::State::Verify
  def call
    play and error
    true
  end

  private

  def format
    'expected %s not to %s'
  end
end
