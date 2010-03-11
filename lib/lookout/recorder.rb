# -*- coding: utf-8 -*-

class Lookout::Recorder < Lookout::BlankSlate

  attr_reader :subject
  def initialize(subject)
    @subject = subject
  end

  def receive(meth)
    extend Lookout::Recorders::Reception
    receive!(meth)
    self
  end

  def have
    extend Lookout::Recorders::State
    message_parts << "to have"
    self
  end

  def be
    extend Lookout::Recorders::State
    message_parts << "to be"
    self
  end

  def delegate(method)
    extend Lookout::Recorders::Delegation
    delegate!(method)
    self
  end

  def subject!
    subject
  end

  def not!
    extend Lookout::ReverseResult
  end

  def verify!
    verify
  end

end
