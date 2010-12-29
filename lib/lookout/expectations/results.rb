# -*- coding: utf-8 -*-

class Lookout::Expectations::Results
  include Enumerable

  def initialize
    @expectations = []
  end

  def <<(result)
    @expectations << result
    self
  end

  def each
    @expectations.each do |expectation|
      yield expectation
    end
    self
  end

  def succeeded?
    all?{ |expectation| expectation.fulfilled? }
  end

  def size
    @expectations.size
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
