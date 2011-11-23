# -*- coding: utf-8 -*-

class Lookout::Expectations::State
  include Lookout::Expectation

  def evaluate
    begin
      result = @block ? Context.new(@expected, &@block).evaluate : false
    rescue Exception => e
      # TODO: Do not depend on @expected#class, @expected#class#==, e#class, or @expected#eql? working.
      # TODO: Still need to guard against errors in #check in this rescue clause.
      return check(e) if StandardError === @expected and @expected.class == e.class
      return Lookout::Results::Fulfilled.new(file, line) if @expected.eql? e.class
      return Lookout::Results::Error.new(file, line,
        if Class === @expected and StandardError >= @expected
          Lookout::Equality.message(@expected, e.class)
        elsif StandardError === @expected
          Lookout::Equality.message(@expected.class, e.class)
        else
          nil
        end,
        e)
    end
    check(result)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end

  private

  def check(actual)
    ((@expected == actual rescue false) or Lookout::Equality.equal? @expected, actual) ?
      Lookout::Results::Fulfilled.new(file, line) :
      Lookout::Results::Failures::State.new(file, line, Lookout::Equality.message(@expected, actual))
  end
end
