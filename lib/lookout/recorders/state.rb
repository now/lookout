# -*- coding: utf-8 -*-

class Lookout::Recorders::State < Lookout::Aphonic
  include Lookout::Recorder

  Error = Class.new(StandardError)

  def initialize(subject, negated, *args)
    super subject, negated
    @methods = Tape.new
    @description = []
    @error = @negated ? 'expected %p not to %s' : 'expected %p to %s'
    method_missing(*args) unless args.empty?
  end

  def verify
    !!@methods.play_for(@subject) ^ @negated or
      raise Error, @error % [@subject, @description.join(' ')]
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
