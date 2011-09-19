# -*- coding: utf-8 -*-

class Lookout::Results
  autoload :Error, 'lookout/results/error'
  autoload :Failure, 'lookout/results/failure'
  autoload :Failures, 'lookout/results/failures'
  autoload :Fulfilled, 'lookout/results/fulfilled'
  autoload :Unsuccessful, 'lookout/results/unsuccessful'

  def initialize
    @listeners = []
  end

  def on_new(&block)
    @listeners << block
    self
  end

  def <<(result)
    @listeners.each do |listener|
      listener.call result
    end
    self
  end
end
