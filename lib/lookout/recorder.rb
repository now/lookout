# -*- coding: utf-8 -*-

module Lookout::Recorder
  def initialize(subject)
    @subject = subject
  end

  # TODO: Rename this to not have it interfere with aphonics.
  def subject!(mocks)
    @subject
  end
end
