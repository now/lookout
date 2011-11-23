# -*- coding: utf-8 -*-

class Lookout::Recorders::State < Lookout::Recorder
  Error = Class.new(StandardError)

  def initialize(subject, *args)
    super subject
    method_missing(*args) unless args.empty?
  end

  def subject!(mocks)
    [@subject, Verify.new(@subject, @recording)]
  end
end
