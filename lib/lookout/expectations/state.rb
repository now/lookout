# -*- coding: utf-8 -*-

class Lookout::Expectations::State
  include Lookout::Expectation

  def evaluate_with_stubs
    check(@block ? instance_exec(@expected, &@block) : false)
  rescue Exception => e
    return check(e) if StandardError === @expected and @expected.class == e.class
    return Lookout::Results::Fulfilled.new(file, line) if @expected.eql? e.class
    Lookout::Results::Error.new(file, line,
      if Class === @expected and StandardError >= @expected
        Lookout::Equality.message(@expected, e.class)
      elsif StandardError === @expected
        Lookout::Equality.message(@expected.class, e.class)
      else
        nil
      end,
      e)
  end

private

  def check(actual)
    (@expected == actual or Lookout::Equality.equal? @expected, actual) ?
      Lookout::Results::Fulfilled.new(file, line) :
      Lookout::Results::Failures::State.new(file, line, Lookout::Equality.message(@expected, actual))
  end
end
