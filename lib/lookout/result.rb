# -*- coding: utf-8 -*-

class Lookout::Result
  class << self
    def is(is)
      [:error, :failure, :fulfilled].each do |type|
        define_method :"#{type}?" do
          type == is
        end
      end
    end
  end

  def initialize(file, line)
    @file, @line = file, line
  end

  attr_reader :file, :line

  def to_s
    '%s:%d' % [file, line]
  end
end
