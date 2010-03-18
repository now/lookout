# -*- coding: utf-8 -*-

module Lookout::Recorders::Reception
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

  def subject!
    # TODO: This is another way of getting the subject into the mockery:
    # @subject = Mocha::Mockery.instance.unnamed_mock if subject.is_a? Mocha::Mock
    methods.play_for subject
    subject
  end

  def verify
    true
  end

  def mocha_error_message(ex)
    ex.message
  end
end
