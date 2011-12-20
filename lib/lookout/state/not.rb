# -*- coding: utf-8 -*-

class Lookout::State::Not < Lookout::State
  def to_lookout_expected
    Lookout::Expected::State.new(@subject, Verify.new(@subject, @recording))
  end
end
