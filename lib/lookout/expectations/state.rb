# -*- coding: utf-8 -*-

class Lookout::Expectations::State
  include Lookout::Expectation

  def execute_with_stubs
    @actual = @block ? instance_eval(&@block) : false
    extend expected == actual ?
      Lookout::Results::Fulfilled :
      Lookout::Results::Failures::State
  rescue Exception => e
    return extend(Lookout::Results::Fulfilled) if expected.eql? e.class
    extend Lookout::Results::Error
    @exception = e
    @message = '%p≠%p' % [e.class, expected] if expected.is_a? Class and expected < StandardError
  end

  attr_reader :actual
end
