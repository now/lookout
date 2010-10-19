# -*- coding: utf-8 -*-

class Lookout::Recorder::Tape
  Method = Struct.new(:name, :args)

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
    @methods.inject(subject){ |result, method| result.send(method.name, *method.args) }
  end
end
