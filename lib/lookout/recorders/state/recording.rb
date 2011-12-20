# -*- coding: utf-8 -*-

class Lookout::Recorders::State::Recording
  def initialize
    @methods = []
  end

  def record(method, args, &block)
    @methods << Method.new(method, args, block)
  end

  def play_for(subject)
    @methods.reduce(subject){ |result, method| method.play_for(result) }
  end

  def to_s
    @methods.map(&:to_s).join(' ')
  end

  private

  Method = Struct.new(:name, :args, :block)
  class Method
    def play_for(subject)
      subject.__send__(name, *args, &block)
    end

    def to_s
      ([name] +
       args.map{ |e| Lookout::Inspect::Argument.new(e).call } +
       (block ? ['{ … }'] : [])).join(' ')
    end
  end
end
