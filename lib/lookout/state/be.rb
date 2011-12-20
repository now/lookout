# -*- coding: utf-8 -*-

class Lookout::State::Be < Lookout::State
  def to_lookout_expected
    Lookout::Expected::State.new(@subject, Verify.new(@subject, @recording))
  end

  private

  class Verify < Lookout::State::Verify
    private

    def format
      'expected %s to be %s'
    end
  end
end
