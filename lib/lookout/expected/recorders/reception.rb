# -*- coding: utf-8 -*-

class Lookout::Expected::Recorders::Reception < Lookout::Expected::Object
  def initialize(subject, recording, method, *args, &body)
    super subject
    @recording, @method, @args, @body = recording, method, args, body
  end

  def actualize(file, line, &block)
    Lookout::Expect::Recorders::Reception.new(self, file, line, &block)
  end

  def mock(methods)
    methods.define(subject, @method, *@args, @body) do |undefined|
      @recording.play_for undefined
    end
  end
end
