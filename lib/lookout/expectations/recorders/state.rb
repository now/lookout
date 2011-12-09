# -*- coding: utf-8 -*-

class Lookout::Expectations::Recorders::State < Lookout::Expectations::Object
  def check(actual)
    @expected.verify
    Lookout::Results::Fulfilled.new(file, line)
  rescue Lookout::Recorders::State::Error => e
    Lookout::Results::Failures::State.new(file, line, e.message)
  end
end
