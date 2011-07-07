# -*- coding: utf-8 -*-

class Lookout::Results::Unsuccessful
  include Lookout::Results::Instance

  include Enumerable

  def initialize
    super
    @unsuccessful = []
  end

  def <<(result)
    @unsuccessful << result unless result.fulfilled?
    super
    self
  end

  def each
    @unsuccessful.each do |result|
      yield result
    end
    self
  end

  def succeeded?
    @unsuccessful.empty?
  end

  def errors
    select{ |result| result.error? }
  end

  def failures
    select{ |result| result.failure? }
  end
end
