# -*- coding: utf-8 -*-

class Lookout::Expectations::Line < Lookout::Expectations
  def initialize(results, file, line)
    super results
    @target = Lookout::Expectations::Object.new(nil, file, line){
      raise RuntimeError, 'line expectation not found: %s:%d' % [file, line]
    }
    @previous = nil
  end

  def evaluate(&block)
    catch :found_expectation_for_line do
      super
    end
    @results << (@previous || @target).evaluate
    @previous = nil
    self
  end

  def <<(expectation)
    if @previous and @previous <= @target and expectation > @target
      throw :found_expectation_for_line
    else
      @previous = expectation
    end
    self
  end
end
