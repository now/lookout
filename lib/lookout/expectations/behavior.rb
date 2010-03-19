# -*- coding: utf-8 -*-

class Lookout::Expectations::Behavior
  include Lookout::Expectation

  def execute_in_mocha
    expected.subject!
    warn_for_expects do
      instance_exec expected.subject, &@block if @block
    end
    add_mock_recorders_to_mockery
    if expected.verify and mocha_verify
      extend Lookout::Results::Fulfilled
    else
      @message = expected.message
      extend Lookout::Results::Failures::State
    end
  rescue Mocha::ExpectationError => e
    extend Lookout::Results::Failures::Behavior
    @message = expected.mocha_error_message(e)
  rescue Exception => e
    extend Lookout::Results::Error
    @exception = e
  end

private

  def add_mock_recorders_to_mockery
    return unless expected.subject.is_a? Mocha::Mock and
                  not Mocha::Mockery.instance.mocks.include? expected.subject
    Mocha::Mockery.instance.__send__ :add_mock, expected.subject
  end
end
