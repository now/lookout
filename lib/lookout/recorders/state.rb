# -*- coding: utf-8 -*-

class Lookout::Recorders::State < Lookout::Aphonic
  include Lookout::Recorder

  Error = Class.new(StandardError)

  def initialize(subject, negated, verb, *args)
    super subject, negated
    @verb = verb
    @methods = Tape.new
    @description = []
    method_missing(*args) unless args.empty?
  end

  def verify
    !!@methods.play_for(@subject) ^ @negated or
      raise Error,
        case [@negated, @verb]
        when [true, :be]    then 'expected %p not to be %s'
        when [true, :have]  then 'expected %p not to have %s'
        when [true, nil]    then 'expected %p not to %s'
        when [false, :be]   then 'expected %p to be %s'
        when [false, :have] then 'expected %p to have %s'
        when [false, nil]   then 'expected %p to %s'
        end % [@subject, @description.join(' ')]
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
