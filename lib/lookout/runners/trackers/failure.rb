# -*- coding: utf-8 -*-

class Lookout::Runners::Trackers::Failure
  def initialize(results)
    @failed = false
    results.on_new do |result|
      @failed = !(Lookout::Results::Fulfilled === result) unless @failed
    end
  end

  def failed?
    @failed
  end
end
