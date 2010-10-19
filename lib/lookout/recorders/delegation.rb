# -*- coding: utf-8 -*-

module Lookout::Recorders::Delegation
  Error = Class.new(Lookout::Mock::Error)
  Expected = Object.new.freeze

  attr_writer :result

  def to(receiver)
    @receiver = receiver
    self
  end

  def subject!(mocks, stubs)
    object = Object.new
    @mock = mocks.define(object, @method){ Expected }
    stubs.define(subject, @receiver){ object }
    subject
  end

  def verify
    verify_state
    verify_mock
  end

private

  def verify_state
    @result == Expected or
      raise Lookout::Recorders::State::Error,
        'expected %s.%s to return value of %s.%s.%s, not %p' %
          [subject, @method, subject, @receiver, @method, @result]
  end

  def verify_mock
    @mock.verify
  rescue Lookout::Mock::Error => e
    raise Error,
      'expected %s to delegate %s to %s; however, %s.%s was never called: %s' %
        [subject, @method, @receiver, subject, @method, e]
  end

  def delegate!(method)
    @method = method
    recorder = self
    subject.extend Module.new{
      define_method method do |*args|
        recorder.result = super(*args)
      end
    }
  end
end
