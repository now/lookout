# -*- coding: utf-8 -*-

class Lookout::Expectations::State
  include Lookout::Expectation

  def execute_in_mocha
    warn_for_expects do
      @actual = @block ? instance_eval(&@block) : false
    end
    mocha_verify
    extend expected.expectations_equal_to(actual) ?
      Lookout::Results::Fulfilled :
      Lookout::Results::Failures::State
  rescue Exception => e
    return extend(Lookout::Results::Fulfilled) if expected == e.class
    extend Lookout::Results::Error
    @exception = e
    @message = "%p≠%p" % [e.class, expected] if expected.is_a? Class and expected < StandardError
  end

  attr_reader :actual
end
