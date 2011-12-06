# -*- coding: utf-8 -*-

class Lookout::Recorders::Reception < Lookout::Recorder
  def initialize(subject, method, *args, &body)
    super subject
    @method, @args, @body = method, args, body
  end

  def to_lookout_expected
    Lookout::Expected::Recorders::Reception.new(self)
  end

  def subject!(mocks)
    mock = mocks.define(@subject, @method, *@args, &@body)
    @recording.play_for mock
    [@subject, Verify.new(mock)]
  end

  private

  class Verify
    def initialize(mock)
      @mock = mock
    end

    def call
      @mock.verify
      true
    end
  end
end
