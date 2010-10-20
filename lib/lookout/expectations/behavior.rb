# -*- coding: utf-8 -*-

class Lookout::Expectations::Behavior
  include Lookout::Expectation

  def execute_with_stubs
    Lookout::Mock.methods do |mocks|
      @expected.subject! mocks, @stubs
      instance_exec @expected.subject, &@block if @block
      @expected.verify
    end
    extend Lookout::Results::Fulfilled
  rescue Lookout::Recorders::State::Error => e
    extend Lookout::Results::Failures::State
    @message = e.message
  rescue Lookout::Mock::Error => e
    extend Lookout::Results::Failures::Behavior
    @message = e.message
  rescue Exception => e
    extend Lookout::Results::Error
    @exception = e
  end
end
