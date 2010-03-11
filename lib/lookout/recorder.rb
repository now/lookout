# -*- coding: utf-8 -*-

class Lookout::Recorder < Lookout::BlankSlate

  attr_reader :subject
  def initialize(subject)
    @subject = subject
  end

  def receive(meth)
    extend Lookout::MockRecorder
    receive!(meth)
    self
  end

  def have
    extend Lookout::StateBasedRecorder
    message_parts << "to have"
    self
  end

  def be
    extend Lookout::StateBasedRecorder
    message_parts << "to be"
    self
  end

  def delegate(method)
    extend Lookout::DelegateRecorder
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
