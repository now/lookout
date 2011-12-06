# -*- coding: utf-8 -*-

class Lookout::Expected::Recorders::Reception < Lookout::Expected::Object
  def initialize(subject, recording, method, *args, &body)
    super subject
    @recording, @method, @args, @body = recording, method, args, body
  end

  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Recorders::Reception.new(self, file, line, &block)
  end

  def mock(mocks)
    mocks.define(subject, @method, *@args, &@body).tap{ |mock|
      @recording.play_for mock
    }
  end
end
