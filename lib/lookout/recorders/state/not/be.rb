# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Not::Be < Lookout::Recorders::State
  def subject!(mocks)
    [@subject, Verify.new(@subject, @recording)]
  end

  private

  class Verify < Lookout::Recorders::State::Not::Verify
    private

    def format
      'expected %s not to be %s'
    end
  end
end
