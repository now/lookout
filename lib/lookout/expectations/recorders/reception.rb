# -*- coding: utf-8 -*-

class Lookout::Expectations::Recorders::Reception < Lookout::Expectations::Object
  private

  def evaluate_in_context
    Lookout::Mock.methods do |mocks|
      mock = @expected.mock(mocks)
      super
      mock
    end
  end

  def check(actual)
    actual.verify
    Lookout::Results::Fulfilled.new(file, line)
  rescue Lookout::Mock::Error => e
    return Lookout::Results::Failures::Behavior.new(file, line, e.message)
  end
end
