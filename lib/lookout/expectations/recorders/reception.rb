# -*- coding: utf-8 -*-

class Lookout::Expectations::Recorders::Reception
  include Lookout::Expectation

  def evaluate
    Lookout::Mock.methods do |mocks|
      mock = @expected.mock(mocks)
      Context.new(@expected.subject, &@block).evaluate
      begin
        mock.verify
      rescue Lookout::Mock::Error => e
        # TODO: Guard against e#message failing?
        return Lookout::Results::Failures::Behavior.new(file, line, e.message)
      end
    end
    Lookout::Results::Fulfilled.new(file, line)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
