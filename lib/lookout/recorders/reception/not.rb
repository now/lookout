# -*- coding: utf-8 -*-

class Lookout::Recorders::Reception::Not < Lookout::Recorders::Reception
  def initialize(subject, method, *args, &body)
    super
    @recording.record :never, []
  end
end
