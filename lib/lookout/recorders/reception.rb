# -*- coding: utf-8 -*-

class Lookout::Recorders::Reception < Lookout::Recorder
  def initialize(subject, method, *args, &body)
    super subject
    @method, @args, @body = method, args, body
  end

  def to_lookout_expected
    Lookout::Expected::Recorders::Reception.new(@subject, @recording, @method, *@args, &@body)
  end
end
