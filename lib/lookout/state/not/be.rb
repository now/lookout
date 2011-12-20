# -*- coding: utf-8 -*-

class Lookout::State::Not::Be < Lookout::State
  def to_lookout_expected
    Lookout::Expected::State.new(@subject, Verify.new(@subject, @recording))
  end

  private

  class Verify < Lookout::State::Not::Verify
    private

    def format
      'expected %s not to be %s'
    end
  end
end
