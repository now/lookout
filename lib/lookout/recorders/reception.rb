# -*- coding: utf-8 -*-

class Lookout::Recorders::Reception < Lookout::Aphonic
  include Lookout::Recorder

  def initialize(subject, negated, method, *args, &body)
    super subject, negated
    @method, @args, @body = method, args, body
    @methods = Tape.new
  end

  def subject!(mocks)
    @mock = mocks.define(@subject, @method, *@args, &@body).tap{ |m| m.never if @negated }
    @methods.play_for @mock
    super
  end

  def verify
    @mock.verify
  end

private

  # TODO: Why aren’t we recording the block?
  def method_missing(method, *args, &block)
    @methods.record method, args
    self
  end
end
