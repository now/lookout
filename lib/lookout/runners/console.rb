# -*- coding: utf-8 -*-

class Lookout::Runners::Console
  def initialize(results = Lookout::Results::Unsuccessful.new,
                 expectations = Lookout::Expectations.new(results,
                                                          ENV['LINE'] && ENV['LINE'].to_i),
                 ui = Lookout::UI::Console.new(results))
    @results, @expectations, @ui = results, expectations, ui
    @ui.start
  end

  def install
    at_exit do
      next if $!
      @expectations.flush
      @ui.summarize
      exit 1 unless @results.succeeded?
    end
    self
  end

  def expectations_eval(&block)
    @expectations.instance_eval(&block)
  rescue Interrupt, NoMemoryError, SignalException, SystemExit
    raise
  rescue Exception => e
    raise unless location = Array(e.backtrace).first
    file, line = Lookout.location(location)
    raise unless file and line
    @results << Lookout::Results::Error.new(file, line, nil, e)
  end
end
