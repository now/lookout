# -*- coding: utf-8 -*-

class Lookout::Expectations::Behavior
  include Lookout::Expectation

  def execute_with_stubs
    Lookout::Mock.ing do |mocks|
      expected.subject! mocks, @stubs
      instance_exec expected.subject, &@block if @block
      if expected.verify and mocks.verify
        extend Lookout::Results::Fulfilled
      else
        @message = expected.message
        extend Lookout::Results::Failures::State
      end
    end
  rescue Lookout::Mock::Error => e
    extend Lookout::Results::Failures::Behavior
    # TODO: Abolish this.  If delegation expectations need to go, so be it.
    # TODO: Delegation should throw error.
    @message = expected.mocking_error_message(e)
  rescue Exception => e
    extend Lookout::Results::Error
    @exception = e
  end
end
