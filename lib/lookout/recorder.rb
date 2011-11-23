# -*- coding: utf-8 -*-

class Lookout::Recorder < Lookout::Aphonic
  Lookout::Expectation.map self, Lookout::Expectations::Behavior

  def initialize(subject)
    @subject = subject
    @recording = Tape.new
  end

  # Subclasses have to implement #subject!(mocks).
  # TODO: Rename this to not have it interfere with aphonics.

  private

  # TODO: Why aren’t we recording the block?
  def method_missing(method, *args, &block)
    @recording.record method, args
    self
  end
end
