# -*- coding: utf-8 -*-

module Lookout::Recorder
  def initialize(subject, negated = false)
    @subject, @negated = subject, negated
  end

  def subject!(mocks)
    @subject
  end

  # TODO: #verify and #subject! shouldn’t be defined on these objects, as they
  # will interfere with the recording.
end
