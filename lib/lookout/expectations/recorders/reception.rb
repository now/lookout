# -*- coding: utf-8 -*-

class Lookout::Expectations::Recorders::Reception
  include Lookout::Expectation

  def evaluate
    Lookout::Mock.methods do |mocks|
      mock = @expected.mock(mocks)
      Context.new(@expected.subject, &@block).evaluate
      mock.verify
    end
    Lookout::Results::Fulfilled.new(file, line)
  rescue Lookout::Mock::Error => e
    Lookout::Results::Failures::Behavior.new(file, line, e.message)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
