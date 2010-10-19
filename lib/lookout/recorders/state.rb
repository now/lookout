# -*- coding: utf-8 -*-

module Lookout::Recorders::State
  autoload :Negated, 'lookout/recorders/state/negated'

  def negate
    extend Negated
    description << 'not'
  end

  def verify
    methods.play_for(subject)
  end

  def message
    'expected %s %s' % [subject, description.join(' ')]
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
