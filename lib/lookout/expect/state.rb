# -*- coding: utf-8 -*-

class Lookout::Expect::State < Lookout::Expect::Object
  def check(actual)
    @expected.verify
    Lookout::Results::Success.new(file, line)
  rescue Lookout::State::Error => e
    Lookout::Results::Failure.new(file, line, e.message)
  end
end
