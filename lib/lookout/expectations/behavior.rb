# -*- coding: utf-8 -*-

require 'mocha'

module Lookout::Expectations::Behavior
  def execute
    begin
      mocha_setup
      expected.subject!
      warn_for_expects do
        instance_exec(expected.subject, &block) if block
      end
      if expected.subject.is_a?(Mocha::Mock) &&
          !Mocha::Mockery.instance.mocks.include?(expected.subject)
        Mocha::Mockery.instance.__send__(:add_mock, expected.subject)
      end
      if expected.verify! && mocha_verify
        self.extend(Lookout::Results::Fulfilled)
      else
        self.extend(Lookout::Results::StateBasedFailure)
        self.message = expected.failure_message
      end
    rescue Mocha::ExpectationError => ex
      self.extend(Lookout::Results::BehaviorBasedFailure)
      self.message = expected.mocha_error_message(ex)
    rescue Exception => ex
      self.extend(Lookout::Results::Error)
      self.exception = ex
    ensure
      mocha_teardown
    end
    self
  end

end