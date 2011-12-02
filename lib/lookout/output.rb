# -*- coding: utf-8 -*-

class Lookout::Output
  Lookout::Expectation.map self, Lookout::Expectations::State::Output

  def initialize(output)
    @output = output
  end

  def ==(other)
    self.class == other.class and
      output == other.output
  end

  alias eql? ==

  def hash
    self.class.hash ^ output.hash
  end

  def inspect
    'output(%p)' % output
  end

  def diff(other)
    Lookout::Equality.diff(output, other.output)
  end

  protected

  attr_reader :output
end
