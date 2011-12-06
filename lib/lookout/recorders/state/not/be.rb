# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Not::Be < Lookout::Recorders::State
  def to_lookout_expected
    Lookout::Expected::Recorders::State.new(@subject, Verify.new(@subject, @recording))
  end

  private

  class Verify < Lookout::Recorders::State::Not::Verify
    private

    def format
      'expected %s not to be %s'
    end
  end
end
