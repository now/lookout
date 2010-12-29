# -*- coding: utf-8 -*-

class Lookout::Expectation::State
  include Lookout::Expectation

  def evaluate_with_stubs
    check(@block ? instance_exec(@expected, &@block) : false)
  rescue Exception => e
    return check(e) if @expected.is_a? StandardError and @expected.class == e.class
    return Lookout::Results::Fulfilled.new(file, line) if @expected.eql? e.class
    if @expected.is_a? Class and @expected <= StandardError
      Lookout::Results::Error.new(file, line, Lookout::Equality.message(@expected, e.class), e)
    elsif @expected.is_a? StandardError
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
