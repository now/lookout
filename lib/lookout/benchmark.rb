# -*- coding: utf-8 -*-

module Lookout::Benchmark
  class << self
    def time
      start = Time.now.to_f
      yield
      Time.now.to_f - start
    end
  end
end
