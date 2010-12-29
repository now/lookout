# -*- coding: utf-8 -*-

class Lookout::Expectation::State
  include Lookout::Expectation

  def evaluate_with_stubs
    check(@block ? instance_exec(@expected, &@block) : false)
  rescue Exception => e
    return check(e) if StandardError === @expected and @expected.class == e.class
    return Lookout::Results::Fulfilled.new(file, line) if @expected.eql? e.class
    if Class === @expected and StandardError >= @expected
      Lookout::Results::Error.new(file, line, Lookout::Equality.message(@expected, e.class), e)
    elsif StandardError === @expected
      Lookout::Results::Error.new(file, line, Lookout::Equality.message(@expected.class, e.class), e)
    else
      Lookout::Results::Error.new(file, line, nil, e)
    end
  end

private

  def check(actual)
    if @expected == actual or Lookout::Equality.equal? @expected, actual
      Lookout::Results::Fulfilled.new(file, line)
    else
      Lookout::Results::Failures::State.new(file, line, Lookout::Equality.message(@expected, actual))
    end
  end
end
