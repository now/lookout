# -*- coding: utf-8 -*-

class Lookout::Recorder < Lookout::Aphonic
  autoload :Not, 'lookout/recorder/not'
  autoload :Tape, 'lookout/recorder/tape'

  attr_reader :subject

  def initialize(subject)
    @subject = subject
    @negated = false
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

  def delegate(method)
    extend Lookout::Recorders::Delegation
    delegate! method
    self
  end

  def subject!(mocks, stubs)
    subject
  end
end
