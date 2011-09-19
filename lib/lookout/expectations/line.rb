# -*- coding: utf-8 -*-

class Lookout::Expectations::Line < Lookout::Expectations
  def initialize(line, results = Lookout::Results.new)
    super results
    @line = line
    @previous = nil
    @ran_previous = false
  end

  def expect(expected)
    return self if @ran_previous
    expectation = Lookout::Expectation.on(expected, *Lookout.location(caller.first), &Proc.new)
    if @previous and @previous.line <= @line and expectation.line > @line
      flush
      @previous = nil
      @ran_previous = true
    else
      @previous = expectation
    end
    self
  end

  # TODO: It would be great if this method wasn’t necessary.
  def flush
    @results << @previous.evaluate if @previous
    self
  end
end
