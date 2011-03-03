# -*- coding: utf-8 -*-

class Lookout::Recorder < Lookout::Aphonic
  autoload :Not, 'lookout/recorder/not'
  autoload :Tape, 'lookout/recorder/tape'

  def initialize(subject)
    @subject, @negated = subject, false
  end

  def not
    @negated = true
    self
  end

  def receive
    extend Lookout::Recorders::Reception
    receive!
  end

  def be
    extend Lookout::Recorders::State
    @verb = :be
    self
  end

  def have
    extend Lookout::Recorders::State
    @verb = :have
    self
  end

  def subject!(mocks, stubs)
    subject
  end

  attr_reader :subject

  def method_missing(method, *args)
    return super unless method.to_s =~ /\?$/
    extend Lookout::Recorders::State
    @verb = nil
    method_missing method, *args
  end
end
