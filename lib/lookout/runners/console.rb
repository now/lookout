# -*- coding: utf-8 -*-

class Lookout::Runners::Console
  def initialize(results = Lookout::Results.new,
                 expectations = Lookout::Expectations.new(results),
                 ui = Lookout::UI::Console.new(results))
    @results, @expectations, @ui = results, expectations, ui
    @ui.start
    @failed = Lookout::Runners::Trackers::Failure.new(@results)
  end

  def install
    Kernel.module_exec(self) do |runner|
      define_method :Expectations do |&block|
        runner.expectations_eval(&block)
      end
    end
    self
  end

  def load(file)
    expectations_eval do
      begin
        load file
      rescue SyntaxError => e
        raise unless matches = %r{\A(.*?:\d+): (.*)}m.match(e.message)
        raise SyntaxError, matches[2], [matches[1]]
      end
    end
  end

  def exit
    @expectations.flush
    @ui.flush
    super 1 if @failed.failed?
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
