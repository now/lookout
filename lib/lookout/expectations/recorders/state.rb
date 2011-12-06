# -*- coding: utf-8 -*-

class Lookout::Expectations::Recorders::State
  include Lookout::Expectation

  def evaluate
    subject, verify = @expected.subject!
    Context.new(subject, &@block).evaluate
    verify.call
    Lookout::Results::Fulfilled.new(file, line)
  rescue Lookout::Recorders::State::Error => e
    Lookout::Results::Failures::State.new(file, line, e.message)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
