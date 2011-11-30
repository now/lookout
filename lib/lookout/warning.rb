# -*- coding: utf-8 -*-

class Lookout::Warning
  Lookout::Expectation.map self, Lookout::Expectations::State::Warning

  def initialize(warning)
    @warning = warning.chomp
  end

  def ==(other)
    self.class == other.class and
      warning == other.warning
  end

  alias eql? ==

  def hash
    self.class.hash ^ warning.hash
  end

  def ===(other)
    self == other or
    (self.class == other.class and
     /\A.*?:\d+: warning: #{Regexp.escape(warning)}\Z/ =~ other.warning)
  end

  def inspect
    'warning(%p)' % warning
  end

  protected

  attr_reader :warning
end
