# -*- coding: utf-8 -*-

class Lookout::Runners::Console
  def initialize(results = Lookout::Results.new,
                 expectations = Lookout::Expectations.new(results),
                 ui = Lookout::UI::Console.new(results))
    @expectations, @ui = expectations, ui
    @failed = Lookout::Runners::Trackers::Failure.new(results)
    @ui.start
  end

  def install
    self
  end

  def load(path)
    @expectations.load path
    self
  end

  def exit
    @ui.flush
    super false if @failed.failed?
    self
  end
end
