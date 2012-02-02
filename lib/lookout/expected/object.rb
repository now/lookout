# -*- coding: utf-8 -*-

class Lookout::Expected::Object
  def initialize(subject)
    @subject = subject
  end

  def actualize(file, line, &block)
    Lookout::Expect::Object.new(self, file, line, &block)
  end

  def =~(other)
    subject == other
  end

  def difference(other)
    self =~ other ? nil : Lookout::Difference::Object.new(other, subject)
  end

  # TODO: Might be able to remove this.
  attr_reader :subject
end
