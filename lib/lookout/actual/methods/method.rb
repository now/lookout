# -*- coding: utf-8 -*-

class Lookout::Actual::Methods::Method
  def initialize(name, *args, &block)
    @name, @args, @block = name, args, block
  end

  def call(subject)
    subject.__send__(name, *args, &block)
  end

  def ==(other)
    self.class == other.class and
      name == other.name and
      args == other.args and
      block == other.block
  end

  def to_s
    '#%s%s%s' % [name,
                args.empty? ? '' : '(%s)' % Lookout::Inspect::Argument.list(*args),
                block ? '{ … }' : '']
  end

  alias inspect to_s

  protected

  attr_reader :name, :args, :block
end
