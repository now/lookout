# -*- coding: utf-8 -*-

class Lookout::Recorders::State < Lookout::Aphonic
  Error = Class.new(StandardError)

  def initialize(subject, *args)
    @subject = subject
    @recording = Recording.new
    method_missing(*args) unless args.empty?
  end

  def to_lookout_expected
    Lookout::Expected::Recorders::State.new(@subject, Verify.new(@subject, @recording))
  end

  private

  def method_missing(method, *args, &block)
    @recording.record method, args, &block
    self
  end
end
