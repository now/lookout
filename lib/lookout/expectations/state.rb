# -*- coding: utf-8 -*-

class Lookout::Expectations::State
  include Lookout::Expectation

  def execute_with_stubs
    actual = @block ? instance_exec(@expected, &@block) : false
    if @expected == actual
      extend Lookout::Results::Fulfilled
    else
      extend Lookout::Results::Failures::State
      @message = ('%p≠%p' % [actual, @expected]).tap{ |message|
        diff = Lookout::Utilities.diff(@expected, actual)
        message << ': ' << diff if diff
      }
    end
  rescue Exception => e
    return extend(Lookout::Results::Fulfilled) if @expected.eql? e.class
    extend Lookout::Results::Error
    @exception = e
    @message = '%p≠%p' % [e.class, @expected] if @expected.is_a? Class and @expected < StandardError
  end
end
