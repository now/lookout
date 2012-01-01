# -*- coding: utf-8 -*-

class Lookout::State::Have < Lookout::State
  def to_lookout_expected
    Lookout::Expected::Lookout::State.new(@subject, Verify.new(@subject, @recording))
  end

  private

  class Verify < Lookout::State::Verify
    private

    def format
      'expected %s to have %s'
    end
  end
end
