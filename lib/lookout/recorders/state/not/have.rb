# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Not::Have < Lookout::Recorders::State::Not
  def to_lookout_expected
    Lookout::Expected::Recorders::State.new(@subject, Verify.new(@subject, @recording))
  end

  private

  class Verify < Lookout::Recorders::State::Not::Verify
    private

    def format
      'expected %s not to have %s'
    end
  end
end
