# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Have < Lookout::Recorders::State
  def subject!(mocks)
    [@subject, Verify.new(@subject, @methods, @description)]
  end

  private

  class Verify < Lookout::Recorders::State::Verify
    private

    def format
      'expected %p to have %s'
    end
  end
end
