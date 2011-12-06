# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Not < Lookout::Recorders::State
  def to_lookout_expected
    Lookout::Expected::Recorders::State.new(@subject, Verify.new(@subject, @recording))
  end
end
