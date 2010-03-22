# -*- coding: utf-8 -*-

class Lookout::Suite::Results
  include Enumerable

  def initialize
    @expectations = []
  end

  def <<(result)
    @expectations << result
    self
  end

  def each(&block)
    @expectations.each(&block)
  end

  def succeeded?
    all?{ |expectation| expectation.fulfilled? }
  end

  def fulfillments
    select{ |expectation| expectation.fulfilled? }
  end

  def errors
    select{ |expectation| expectation.error? }
  end

  def failures
    select{ |expectation| expectation.failure? }
  end
end
