# -*- coding: utf-8 -*-

module Expectations::StateBasedExpectation
  def execute
    begin
      mocha_setup
      warn_for_expects do
        self.actual = instance_eval(&block)
      end
      mocha_verify
      if expected.expectations_equal_to(actual)
        self.extend(Expectations::Results::Fulfilled)
      else
        self.extend(Expectations::Results::StateBasedFailure)
      end
    rescue Exception => ex
      return self.extend(Expectations::Results::Fulfilled) if expected == ex.class
      self.extend(Expectations::Results::Error)
      self.exception = ex
      self.message = "%p≠%p" % [ex.class, expected] if expected.is_a? Class and expected < StandardError
      return self
    ensure
      mocha_teardown
    end
  end
end
