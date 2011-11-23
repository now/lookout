# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Not::Be < Lookout::Recorders::State
  def subject!(mocks)
    [@subject, Verify.new(@subject, @methods, @description)]
  end

  private

  class Verify < Lookout::Recorders::State::Not::Verify
    private

    def format
      'expected %p not to be %s'
    end
  end
end
