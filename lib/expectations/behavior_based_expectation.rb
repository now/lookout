module Expectations::BehaviorBasedExpectation
  include Mocha::Standalone

  def execute
    begin
      mocha_setup
      instance_exec expected.mock, &block
      expected.verify
      self.extend(Expectations::Results::Fulfilled)
    rescue Mocha::ExpectationError => ex
      self.extend(Expectations::Results::BehaviorFailure)
      self.message = ex.message
    rescue Exception => ex
      self.extend(Expectations::Results::BehaviorBasedError)
      self.exception = ex
    ensure
      mocha_teardown
    end
    self
  end
  
end