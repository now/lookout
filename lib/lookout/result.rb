# -*- coding: utf-8 -*-

module Lookout::Result
  def initialize(file, line)
    @file, @line = file, line
  end

  def ==(other)
    self.class == other.class and
      file == other.file and line == other.line
  end

  alias eql? ==

  attr_reader :file, :line

  def to_s
    '%s:%d' % [file, line]
  end
end
