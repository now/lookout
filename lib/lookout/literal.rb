# -*- coding: utf-8 -*-

class Lookout::Literal
  def initialize(subject)
    @subject = subject
  end

  def ==(other)
    self.class == other.class and
      subject == other.subject
  end

  alias eql? ==

  def hash
    self.class.hash ^ subject.hash
  end

  def inspect
    'literal(%p)' % output
  end

  def to_lookout_expected
    Lookout::Expected::Object.new(@subject)
  end

  protected

  attr_reader :subject
end
