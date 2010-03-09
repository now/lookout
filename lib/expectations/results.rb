# -*- coding: utf-8 -*-

module Expectations::Results
  def initialize(file, line)
    self.line, self.file = line, file
  end

  def fulfilled?
    self.is_a?(Expectations::Results::Fulfilled)
  end

  def failure?
    self.is_a?(Expectations::Results::StateBasedFailure) || self.is_a?(Expectations::Results::BehaviorBasedFailure)
  end

  def error?
    self.is_a?(Expectations::Results::Error)
  end

  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def char(arg)
      define_method :char do
        arg
      end
    end
  end
end

module Expectations::Results
  module StateBasedFailure
    include Expectations::Results
    char "F"
    attr_writer :message
    def message
      return @message if instance_variable_defined? :@message and @message
      result = "%p≠%p" % [expected, actual]
      result += ":#{expected.diff(actual)}" if expected.is_a? String and actual.is_a? String
      result
    end
  end
end

module Expectations::Results
  module BehaviorBasedFailure
    attr_accessor :message
    include Expectations::Results
    char "F"
  end
end

module Expectations::Results
  module Fulfilled
    include Expectations::Results
    char "."
  end
end

module Expectations::Results
  module Error
    attr_accessor :exception, :message
    include Expectations::Results
    char "E"
  end
end
