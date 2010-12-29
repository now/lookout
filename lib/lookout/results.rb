# -*- coding: utf-8 -*-

class Lookout::Results
  autoload :Error, 'lookout/results/error'
  autoload :Failure, 'lookout/results/failure'
  autoload :Failures, 'lookout/results/failures'
  autoload :Fulfilled, 'lookout/results/fulfilled'

  include Enumerable

  def initialize
    @results = []
  end

  def <<(result)
    @results << result
    self
  end

  def each
    @results.each do |result|
      yield result
    end
    self
  end

  def succeeded?
    all?{ |result| result.fulfilled? }
  end

  def size
    @results.size
  end

  def fulfillments
    select{ |result| result.fulfilled? }
  end

  def errors
    select{ |result| result.error? }
  end

  def failures
    select{ |result| result.failure? }
  end
end
