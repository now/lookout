# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Verify
  def initialize(subject, methods)
    @subject, @methods = subject, methods
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
      format % [@subject, @methods]
  end

  def format
    'expected %p to %s'
  end
end
