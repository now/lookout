# -*- coding: utf-8 -*-

module Lookout::Result
  include Comparable

  def initialize(file, line)
    @file, @line = file, line
  end

  def <=>(other)
    return nil unless self.class == other.class
    [file, line] <=> [other.file, other.line]
  end

  alias eql? ==

  def hash
    @hash ||= [self.class, file, line].hash
  end

  def to_s
    '%s:%d' % [file, line]
  end

  attr_reader :file, :line
end
