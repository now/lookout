# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Verify
  def initialize(subject, methods, description)
    @subject, @methods, @description = subject, methods, description
  end

  def call
    play or error
  end

  private

  def play
    @methods.play_for(@subject)
  end

  def error
    raise Lookout::Recorders::State::Error,
      format % [@subject, @description.join(' ')]
  end

  def format
    'expected %p to %s'
  end
end
