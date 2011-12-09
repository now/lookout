# -*- coding: utf-8 -*-

class Lookout::Expectations::Context
  def initialize(expectations)
    @expectations = expectations
  end

  private

  def expect(expected, &block)
    @expectations << Lookout::Expectation.on(expected, *Lookout.location(caller.first), &block)
    self
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
end
