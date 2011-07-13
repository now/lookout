# -*- coding: utf-8 -*-

class Lookout::Results::Unsuccessful
  include Lookout::Results::Instance

  include Enumerable

  def initialize
    super
    @unsuccessful = []
  end

  def <<(result)
    @unsuccessful << result unless Lookout::Results::Fulfilled === result
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
    select{ |result| Lookout::Results::Error === result }
  end

  def failures
    select{ |result| Lookout::Results::Failure === result }
  end
end
