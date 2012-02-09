# -*- coding: utf-8 -*-

class Lookout::Actual::Methods
  def initialize
    @methods = []
  end

  def push(method, *args, &block)
    methods << Method.new(method, *args, &block)
    self
  end

  def call(subject)
    methods.reduce(subject){ |result, method| method.call(result) }
  end

  def ==(other)
    self.class == other.class and
      methods == other.methods
  end

  alias eql? ==

  def to_s
    '#' + methods.map(&:to_s).join('#')
  end

  alias inspect to_s

  protected

  attr_reader :methods
end
