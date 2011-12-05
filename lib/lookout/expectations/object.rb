# -*- coding: utf-8 -*-

class Lookout::Expectations::Object
  include Lookout::Expectation

  def evaluate
    check(@block ? Context.new(subject, &@block).evaluate : false)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end

  private

  def subject
    @expected
  end

  def check(actual)
    ((@expected == actual rescue false) or equality.equal? @expected, actual) ?
      Lookout::Results::Fulfilled.new(file, line) :
      Lookout::Results::Failures::State.new(file, line, equality.message(@expected, actual))
  end

  def equality
    @equality ||= Lookout::Equalities::Object.new
  end
end
