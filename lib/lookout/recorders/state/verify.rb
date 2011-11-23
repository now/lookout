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
      format % [Lookout::Inspect.new(@subject, 'subject').call, @recording]
  end

  def format
    'expected %s to %s'
  end
end
