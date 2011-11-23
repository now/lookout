# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Be < Lookout::Recorders::State
  def subject!(mocks)
    [@subject, Verify.new(@subject, @methods)]
  end

  private

  class Verify < Lookout::Recorders::State::Verify
    private

    def format
      'expected %p to be %s'
    end
  end
end
