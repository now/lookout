# -*- coding: utf-8 -*-

module Lookout::Recorders::Delegation
  Expected = Object.new.freeze

  attr_writer :result

  def to(receiver)
    @receiver = receiver
    self
  end

  def subject!
    mock = Object.new
    mock.expects(@method).returns(Expected)
    subject.stubs(@receiver).returns(mock)
    subject
  end

  def verify
    @result == Expected
  end

  def message
    'expected %s.%s to return value of %s.%s.%s, not %p' %
      [subject, @method, subject, @receiver, @method, @result]
  end

  def mocha_error_message(error)
    'expected %s to delegate %s to %s; however, %s.%s was never called: %s' %
      [subject, @method, @receiver, subject, @method, error]
  end

private

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
