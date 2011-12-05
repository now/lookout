# -*- coding: utf-8 -*-

class Lookout::Recorder < Lookout::Aphonic
  def initialize(subject)
    @subject = subject
    @recording = Tape.new
  end

  # Subclasses have to implement #subject!(mocks).
  # TODO: Rename this to not have it interfere with aphonics.

  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Behavior.new(self, file, line, &block)
  end

  private

  def method_missing(method, *args, &block)
    @recording.record method, args, &block
    self
  end
end
