# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Be < Lookout::Recorders::State
  def to_lookout_expected
    Lookout::Expected::Recorders::State.new(@subject, Verify.new(@subject, @recording))
  end

  private

  class Verify < Lookout::Recorders::State::Verify
    private

    def format
      'expected %s to be %s'
    end
  end
end
