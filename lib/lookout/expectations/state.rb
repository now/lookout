# -*- coding: utf-8 -*-

class Lookout::Expectations::State
  include Lookout::Expectation

  def execute_with_stubs
    check(@block ? instance_exec(@expected, &@block) : false)
  rescue Exception => e
    return check(e) if @expected.is_a? StandardError and @expected.class == e.class
    return extend(Lookout::Results::Fulfilled) if @expected.eql? e.class
    extend Lookout::Results::Error
    @exception = e
    if @expected.is_a? Class and @expected <= StandardError
      @message = Lookout::Equality.message(@expected, e.class)
    elsif @expected.is_a? StandardError
      @message = Lookout::Equality.message(@expected.class, e.class)
    end
  end

private

  def check(actual)
    if @expected == actual or Lookout::Equality.equal? @expected, actual
      extend Lookout::Results::Fulfilled
    else
      extend Lookout::Results::Failures::State
      @message = Lookout::Equality.message(@expected, actual)
    end
  end
end
