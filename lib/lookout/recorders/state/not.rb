# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Not < Lookout::Recorders::State
  def subject!(mocks)
    [@subject, Verify.new(@subject, @recording)]
  end
end
