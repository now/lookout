# -*- coding: utf-8 -*-

class Lookout::Expectations
  def initialize(results = Lookout::Results.new)
    @results = results
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

  def expect(expected, &block)
    @results << Lookout::Expectation.on(expected, *Lookout.location(caller.first), &block).evaluate
    self
  end

  # TODO: It would be great if this method wasn’t necessary.
  def flush
    self
  end
end
