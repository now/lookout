# -*- coding: utf-8 -*-

class Lookout::Results::Trackers::Failure
  def initialize(results)
    @failed = false
    results.on_new do |result|
      @failed = !(Lookout::Results::Success === result) unless @failed
    end
  end

  def failed?
    @failed
  end
end
