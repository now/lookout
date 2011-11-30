# -*- coding: utf-8 -*-

class Lookout::Warning < Lookout::Output
  Lookout::Expectation.map self, Lookout::Expectations::State::Warning, :before => Lookout::Output

  def initialize(output)
    super output.chomp
  end

  def ===(other)
    self == other or
      (self.class == other.class and normalized == other.normalized)
  end

  def inspect
    'warning(%p)' % output
  end

  def diff(other)
    self == normalized ? super(other.normalized) : normalized.diff(other)
  end

  protected

  def normalized
    normalized = output.sub(/\A.*?:\d+: warning: /, '')
    output == normalized ? self : self.class.new(normalized)
  end
end
