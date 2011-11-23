# -*- coding: utf-8 -*-

class Lookout::Expectations::Behavior
  include Lookout::Expectation

  def evaluate
    Lookout::Mock.methods do |mocks|
      Context.new(@expected.subject!(mocks), &@block).evaluate
      @expected.verify
    end
    Lookout::Results::Fulfilled.new(file, line)
  rescue Lookout::Recorders::State::Error => e
    Lookout::Results::Failures::State.new(file, line, e.message)
  rescue Lookout::Mock::Error => e
    Lookout::Results::Failures::Behavior.new(file, line, e.message)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
