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
        extend Lookout::Results::Fulfilled
      else
        extend Lookout::Results::Failures::State
        self.message = expected.failure_message
      end
    rescue Mocha::ExpectationError => ex
      extend Lookout::Results::Failures::Behavior
      self.message = expected.mocha_error_message(ex)
    rescue Exception => ex
      extend Lookout::Results::Error
      self.exception = ex
    ensure
      mocha_teardown
    end
    self
  end

end
