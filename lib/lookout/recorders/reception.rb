# -*- coding: utf-8 -*-

module Lookout::Recorders::Reception
  def subject!
    methods.play_for subject
    subject
  end

  def verify
    true
  end

  def mocha_error_message(error)
    error.message
  end

private

  def methods
    @methods ||= Lookout::Tape.new
  end

  def receive!(method)
    methods.record :expects, [method]
    self
  end

  def method_missing(method, *args)
    super if methods.empty?
    methods.record method, args
    self
  end
end
