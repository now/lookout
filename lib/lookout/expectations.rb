# -*- coding: utf-8 -*-

class Lookout::Expectations
  autoload :Behavior, 'lookout/expectations/behavior'
  autoload :State, 'lookout/expectations/state'

  def initialize(results = Lookout::Results::Unsuccessful.new, line = nil)
    @results, @line = results, line
    @previous = nil
    @ran_previous = false
  end

  def mock
    Lookout::Mock::Object.new
  end

  def arg
    Lookout::Mock::Method::Arguments::Anything.new
  end

  def without_arguments
    Lookout::Mock::Method::Arguments::None.new
  end

  def stub
    Lookout::Stub::Object.new
  end

  def output(string)
    Lookout::Output.new(string)
  end

  def warning(string)
    Lookout::Warning.new(string)
  end

  def xml(string)
    Lookout::XML.new(string)
  end

  def expect(expected, &block)
    expectation = Lookout::Expectation.on(expected, *Lookout.location(caller.first), &block)
    if @line
      unless @ran_previous
        if @previous and @previous.line <= @line and expectation.line > @line
          @results << @previous.evaluate
          @ran_previous = true
          @previous = nil
        else
          @previous = expectation
        end
      end
    else
      @results << expectation.evaluate
    end
    self
  end

  # TODO: It would be great if this method wasn’t necessary.
  def flush
    @results << @previous.evaluate if @previous
    self
  end
end
