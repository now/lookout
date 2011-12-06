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

  def hash
    self.class.hash ^ output.hash
  end

  def inspect
    'output(%p)' % output
  end

  def diff(other)
    output.to_lookout_expected.diff(other.output)
  end

  def to_lookout_expected
    Lookout::Expected::Output.new(self)
  end

  protected

  attr_reader :output
end
