# -*- coding: utf-8 -*-

class Lookout::Recorders::State < Lookout::Recorder
  Error = Class.new(StandardError)

  def initialize(subject, *args)
    super subject
    method_missing(*args) unless args.empty?
  end

  def to_lookout_expected
    Lookout::Expected::Recorders::State.new(@subject, Verify.new(@subject, @recording))
  end
end
