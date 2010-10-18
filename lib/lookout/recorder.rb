# -*- coding: utf-8 -*-

class Lookout::Recorder < Lookout::Aphonic
  attr_reader :subject

  def initialize(subject)
    @subject = subject
  end

  def not
    extend Lookout::Negated, Lookout::Recorders::State
    description << 'not'
    self
  end

  def receive
    extend Lookout::Recorders::Reception
    receive!
  end

  def have
    extend Lookout::Recorders::State
    description << 'to have'
    self
  end

  def be
    extend Lookout::Recorders::State
    description << 'to be'
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
