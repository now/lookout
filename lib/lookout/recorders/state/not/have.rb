# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Not::Have < Lookout::Recorders::State::Not
  def subject!(mocks)
    [@subject, Verify.new(@subject, @recording)]
  end

  private

  class Verify < Lookout::Recorders::State::Not::Verify
    private

    def format
      'expected %p not to have %s'
    end
  end
end
