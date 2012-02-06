# -*- coding: utf-8 -*-

class Lookout::Expect::Object
  include Comparable

  def initialize(expected, file, line, &block)
    @expected, @file, @line, @block = expected, file, line, block
  end

  def call
    check(evaluate_block)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end

  def <=>(other)
    return nil unless self.class == other.class
    [file, line] <=> [other.file, other.line]
  end

  protected

  attr_reader :file, :line

  private

  def evaluate_block(subject = @expected.subject)
    Context.new(subject, &@block).evaluate
  end

  def check(actual)
    (difference = @expected.difference(actual)) ?
      Lookout::Results::Failure.new(file, line, difference) :
      Lookout::Results::Success.new(file, line)
  end
end
