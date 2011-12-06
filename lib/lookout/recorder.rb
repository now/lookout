# -*- coding: utf-8 -*-

class Lookout::Recorder < Lookout::Aphonic
  def initialize(subject)
    @subject = subject
    @recording = Tape.new
  end

  # Subclasses have to implement #subject!(mocks).
  # TODO: Rename this to not have it interfere with aphonics.

  def to_lookout_expected
    Lookout::Expected::Behavior.new(self)
  end

  private

  def method_missing(method, *args, &block)
    @recording.record method, args, &block
    self
  end
end
