# -*- coding: utf-8 -*-

class Lookout::Expect::Lookout::State < Lookout::Expect::Object
  def check(actual)
    @expected.verify
    Lookout::Results::Success.new(file, line)
  rescue Lookout::State::Error => e
    Lookout::Results::Failure.new(file, line, Lookout::Difference.new(e.message))
  end
end
