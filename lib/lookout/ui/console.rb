# -*- coding: utf-8 -*-

class Lookout::UI::Console
  def initialize(results, io = $stderr)
    @io = io
    results.on_new do |result|
      @io.puts result unless Lookout::Results::Fulfilled === result
    end
  end

  def flush
    @io.flush
    self
  end
end
