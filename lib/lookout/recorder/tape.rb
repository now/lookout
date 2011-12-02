# -*- coding: utf-8 -*-

class Lookout::Recorder::Tape
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
      # TODO: Use Lookout::Inspect here.
      ([name] + args.map(&:inspect) + (block ? ['{ … }'] : [])).join(' ')
    end
  end
end
