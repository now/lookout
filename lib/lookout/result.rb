# -*- coding: utf-8 -*-

module Lookout::Result
  def initialize(file, line)
    @file, @line = file, line
  end

  attr_reader :file, :line

  def to_s
    '%s:%d' % [file, line]
  end
end
