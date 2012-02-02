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
    output.to_lookout_expected.difference(other.output).diff
  end

  def to_lookout_expected
    Lookout::Expected::Lookout::Output.new(self)
  end

  protected

  attr_reader :output
end
