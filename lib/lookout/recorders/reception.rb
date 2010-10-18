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
    @method = MethodRecorder.new(self, @negated)
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
    def initialize(recorder, negated)
      @recorder, @negated = recorder, negated
    end

    def method_missing(method, *args, &body)
      @method, @args, @body = method, args, body
      @recorder
    end

    def define(mocks)
      mocks.define(@recorder.subject, @method, *@args, &@body).tap{ |m| m.never if @negated }
    end
  end
end
