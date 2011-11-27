# -*- coding: utf-8 -*-

class Lookout::Expectations
  def initialize(results = Lookout::Results.new)
    @results = results
    @context = Context.new(self)
  end

  def evaluate(&block)
    @context.instance_eval(&block)
    self
  end

  def <<(expectation)
    @results << expectation.evaluate
    self
  end
end
