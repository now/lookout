# -*- coding: utf-8 -*-

class Lookout::Expectations::Behavior
  include Lookout::Expectation

  def evaluate
    Lookout::Mock.methods do |mocks|
      @expected.subject! mocks
      Context.new(@expected.subject, &@block).evaluate if @block
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
