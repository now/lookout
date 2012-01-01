# -*- coding: utf-8 -*-

class Lookout::State::Not::Have < Lookout::State::Not
  def to_lookout_expected
    Lookout::Expected::Lookout::State.new(@subject, Verify.new(@subject, @recording))
  end

  private

  class Verify < Lookout::State::Not::Verify
    private

    def format
      'expected %s not to have %s'
    end
  end
end
