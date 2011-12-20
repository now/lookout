# -*- coding: utf-8 -*-

class Lookout::Expect::State < Lookout::Expect::Object
  def check(actual)
    @expected.verify
    Lookout::Results::Fulfilled.new(file, line)
  rescue Lookout::State::Error => e
    Lookout::Results::Failures::State.new(file, line, e.message)
  end
end
