# -*- coding: utf-8 -*-

module Lookout::Recorders::State
  def methods
    @methods ||= Lookout::Tape.new
  end

  def message_parts
    @message_parts ||= self.is_a?(Lookout::Negated) ? ['not'] : []
  end

  def method_missing(method, *args)
    message_parts << method.to_s
    args.each{ |arg| message_parts << arg.inspect }
    methods.record method, args
    self
  end

  def verify
    methods.play_for(subject)
  end

  def failure_message
    "expected #{subject} #{message_parts.join(' ')}"
  end
end
