# -*- coding: utf-8 -*-

class Lookout::Output
  def initialize(output)
    @output = output
  end

  def ==(other)
    self.class == other.class and
      output == other.output
  end

  alias eql? ==
  alias === ==

  def hash
    self.class.hash ^ output.hash
  end

  def inspect
    'output(%p)' % output
  end

  def diff(other)
    Lookout::Equality.diff(output, other.output)
  end

  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::State::Output.new(self, file, line, &block)
  end

  protected

  attr_reader :output
end
