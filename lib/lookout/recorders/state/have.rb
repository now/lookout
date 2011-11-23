# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Have < Lookout::Recorders::State
  def subject!(mocks)
    [@subject, Verify.new(@subject, @recording)]
  end

  private

  class Verify < Lookout::Recorders::State::Verify
    private

    def format
      'expected %s to have %s'
    end
  end
end
