# -*- coding: utf-8 -*-

module Lookout::Recorders::Reception
  def subject!(mocks, stubs)
    @mock = @method._lookout_define(mocks)
    methods.play_for @mock
    subject
  end

  def verify
    @mock.verify
  end

private

  def receive!
    @method = Method.new(self, @negated)
  end

  def methods
    @methods ||= Lookout::Recorder::Tape.new
  end

  def method_missing(method, *args, &block)
    super unless defined? @method
    methods.record method, args
    self
  end

  class Method < Lookout::Aphonic
    undef extend
    undef is_a?

    def initialize(recorder, negated)
      @recorder, @negated = recorder, negated
    end

    def method_missing(method, *args, &body)
      @method, @args, @body = method, args, body
      @recorder
    end

    def _lookout_define(mocks)
      mocks.define(@recorder.subject, @method, *@args, &@body).tap{ |m| m.never if @negated }
    end
  end
end
