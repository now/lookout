# -*- coding: utf-8 -*-

class Lookout::Recorder::Tape
  def initialize
    @methods = []
  end

  def empty?
    @methods.empty?
  end

  def record(method, args)
    @methods << Method.new(method, args)
  end

  def play_for(subject)
    @methods.reduce(subject){ |result, method| result.send(method.name, *method.args) }
  end

  def to_s
    @methods.map(&:to_s).join(' ')
  end

  private

  Method = Struct.new(:name, :args)
  class Method
    def to_s
      ([name] + args.map(&:inspect)).join(' ')
    end
  end
end
