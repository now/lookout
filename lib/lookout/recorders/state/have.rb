# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Have < Lookout::Recorders::State
  def to_lookout_expected
    Lookout::Expected::Recorders::State.new(@subject, Verify.new(@subject, @recording))
  end

  private

  class Verify < Lookout::Recorders::State::Verify
    private

    def format
      'expected %s to have %s'
    end
  end
end
