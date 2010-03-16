# -*- coding: utf-8 -*-

module Lookout::Expectations::State
  def execute
    begin
      mocha_setup
      warn_for_expects do
        self.actual = block ? instance_eval(&block) : false
      end
      mocha_verify
      if expected.expectations_equal_to(actual)
        extend Lookout::Results::Fulfilled
      else
        extend Lookout::Results::Failures::State
      end
    rescue Exception => ex
      return extend(Lookout::Results::Fulfilled) if expected == ex.class
      extend Lookout::Results::Error
      self.exception = ex
      self.message = "%p≠%p" % [ex.class, expected] if expected.is_a? Class and expected < StandardError
      return self
    ensure
      mocha_teardown
    end
  end
end
