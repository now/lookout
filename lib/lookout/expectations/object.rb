# -*- coding: utf-8 -*-

class Lookout::Expectations::Object
  include Lookout::Expectation

  def evaluate
    check(evaluate_in_context)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end

  private

  def evaluate_in_context(subject = @expected.subject)
    @block ? Context.new(subject, &@block).evaluate : false
  end

  def check(actual)
    @expected =~ actual ?
      Lookout::Results::Fulfilled.new(file, line) :
      Lookout::Results::Failures::State.new(file, line, @expected.message(actual))
  end
end
