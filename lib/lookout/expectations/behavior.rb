# -*- coding: utf-8 -*-

class Lookout::Expectations::Behavior
  include Lookout::Expectation

  def execute_in_mocha
    expected.subject!
    instance_exec(expected.subject, &block) if block
    if expected.subject.is_a? Mocha::Mock and
       not Mocha::Mockery.instance.mocks.include? expected.subject
      Mocha::Mockery.instance.__send__(:add_mock, expected.subject)
    end
    if expected.verify! and mocha_verify
      extend Lookout::Results::Fulfilled
    else
      @message = expected.failure_message
      extend Lookout::Results::Failures::State
    end
  rescue Mocha::ExpectationError => e
    extend Lookout::Results::Failures::Behavior
    @message = expected.mocha_error_message(e)
  rescue Exception => e
    extend Lookout::Results::Error
    @exception = e
  end
end
