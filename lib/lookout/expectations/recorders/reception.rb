# -*- coding: utf-8 -*-

class Lookout::Expectations::Recorders::Reception < Lookout::Expectations::Object
  def evaluate
    Lookout::Mock.methods do |mocks|
      mock = @expected.mock(mocks)
      evaluate_in_context
      mock.verify
    end
    Lookout::Results::Fulfilled.new(file, line)
  rescue Lookout::Mock::Error => e
    Lookout::Results::Failures::Behavior.new(file, line, e.message)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
