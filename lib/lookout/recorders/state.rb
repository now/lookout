# -*- coding: utf-8 -*-

module Lookout::Recorders::State
  Error = Class.new(StandardError)

  def verify
    !!methods.play_for(subject) ^ @negated or
      raise Error,
        case [@negated, @verb]
        when [true, :be]    then 'expected %p not to be %s'
        when [true, :have]  then 'expected %p not to have %s'
        when [true, nil]    then 'expected %p not to %s'
        when [false, :be]   then 'expected %p to be %s'
        when [false, :have] then 'expected %p to have %s'
        when [false, nil]   then 'expected %p to %s'
        end % [subject, description.join(' ')]
  end

private

  def methods
    @methods ||= Lookout::Recorder::Tape.new
  end

  def description
    @description ||= []
  end

  def method_missing(method, *args)
    description << method.to_s
    args.each{ |arg| description << arg.inspect }
    methods.record method, args
    self
  end
end
