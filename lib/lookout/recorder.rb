# -*- coding: utf-8 -*-

class Lookout::Recorder < Lookout::Aphonic
  def initialize(subject)
    @subject = subject
    @recording = Recording.new
  end

  private

  def method_missing(method, *args, &block)
    @recording.record method, args, &block
    self
  end
end
