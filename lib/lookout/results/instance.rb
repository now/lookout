# -*- coding: utf-8 -*-

module Lookout::Results::Instance
  def initialize
    @listeners = []
  end

  def on_new(&block)
    @listeners << block
  end

  def <<(result)
    @listeners.each do |listener|
      listener.call result
    end
  end
end
