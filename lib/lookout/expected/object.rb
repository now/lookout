# -*- coding: utf-8 -*-

class Lookout::Expected::Object
  def initialize(subject)
    @subject = subject
  end

  def expect(file, line, &block)
    Lookout::Expect::Object.new(self, file, line, &block)
  end

  def difference(other)
    Lookout::Difference::Object.new(other, subject) unless subject == other
  end

  def ==(other)
    self.class == other.class and
      subject == other.subject
  end

  alias eql? ==

  attr_reader :subject
end
