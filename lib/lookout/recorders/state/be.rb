# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Be < Lookout::Recorders::State
  def subject!
    [@subject, Verify.new(@subject, @recording)]
  end

  private

  class Verify < Lookout::Recorders::State::Verify
    private

    def format
      'expected %s to be %s'
    end
  end
end
