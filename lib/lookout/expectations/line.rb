# -*- coding: utf-8 -*-

class Lookout::Expectations::Line < Lookout::Expectations
  def initialize(line, results = Lookout::Results.new)
    super results
    @line = line
    @previous = nil
  end

  def evaluate(&block)
    catch :found_expectation_for_line do
      super
    end
    @results << @previous.evaluate if @previous
    @previous = nil
    self
  end

  def <<(expectation)
    if @previous and @previous.line <= @line and expectation.line > @line
      throw :found_expectation_for_line
    else
      @previous = expectation
    end
    self
  end
end
