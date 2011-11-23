# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Verify
  def initialize(subject, recording)
    @subject, @recording = subject, recording
  end

  def call
    play or error
  end

  private

  def play
    @recording.play_for(@subject)
  end

  def error
    raise Lookout::Recorders::State::Error,
      format % [@subject, @recording]
  end

  def format
    'expected %p to %s'
  end
end
