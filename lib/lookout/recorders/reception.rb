# -*- coding: utf-8 -*-

class Lookout::Recorders::Reception < Lookout::Aphonic
  include Lookout::Recorder

  def initialize(subject, method, *args, &body)
    super subject
    @method, @args, @body = method, args, body
    @methods = Tape.new
  end

  def subject!(mocks)
    mock = mocks.define(@subject, @method, *@args, &@body)
    @methods.play_for mock
    [@subject, Verify.new(mock)]
  end

  private

  # TODO: Why aren’t we recording the block?
  def method_missing(method, *args, &block)
    @methods.record method, args
    self
  end

  class Verify
    def initialize(mock)
      @mock = mock
    end

    def call
      @mock.verify
      true
    end
  end
end
