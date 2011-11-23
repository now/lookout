# -*- coding: utf-8 -*-

class Lookout::Recorders::State < Lookout::Aphonic
  include Lookout::Recorder

  Error = Class.new(StandardError)

  def initialize(subject, *args)
    super subject
    @methods = Tape.new
    @description = []
    @error = 'expected %p to %s'
    method_missing(*args) unless args.empty?
  end

  def verify
    @methods.play_for(@subject) or
      raise Error, @error % [@subject, @description.join(' ')]
    self
  end

  private

  # TODO: Why aren’t we recording the block?
  def method_missing(method, *args, &block)
    @description << method.to_s
    args.each{ |arg| @description << arg.inspect }
    @methods.record method, args
    self
  end
end
