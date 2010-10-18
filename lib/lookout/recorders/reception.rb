# -*- coding: utf-8 -*-

module Lookout::Recorders::Reception
  def subject!(mocks, stubs)
    methods.play_for @method.define(mocks)
    subject
  end

  def verify
    true
  end

  def mocking_error_message(error)
    error.message
  end

private

  def receive!
    @method = MethodRecorder.new(self)
  end

  def methods
    @methods ||= Lookout::Tape.new
  end

  def method_missing(method, *args, &block)
    super unless defined? @method
    methods.record method, args
    self
  end

  class MethodRecorder < Lookout::Aphonic
    def initialize(recorder)
      @recorder = recorder
    end

    def method_missing(method, *args, &body)
      @method, @args, @body = method, args, body
      @recorder
    end

    def define(mocks)
      mocks.define(@recorder.subject, @method, *@args, &@body)
    end
  end
end
