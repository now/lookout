# -*- coding: utf-8 -*-

module Lookout::Recorders::State
  def negate
    extend Lookout::Negated
    description << 'not'
  end

  def verify
    methods.play_for(subject)
  end

  def message
    "expected #{subject} #{description.join(' ')}"
  end

private

  def methods
    @methods ||= Lookout::Tape.new
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
