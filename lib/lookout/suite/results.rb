# -*- coding: utf-8 -*-

class Lookout::Suite::Results
  def initialize
    @expectations = []
  end

  def <<(result)
    expectations << result
    self
  end

  def succeeded?
    expectations.all? { |expectation| expectation.fulfilled? }
  end

  def fulfillments
    expectations.select { |expectation| expectation.fulfilled? }
  end

  def errors
    expectations.select { |expectation| expectation.error? }
  end

  def failures
    expectations.select { |expectation| expectation.failure? }
  end

  attr_reader :expectations
end
