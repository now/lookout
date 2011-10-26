# -*- coding: utf-8 -*-

class Lookout::Results
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
