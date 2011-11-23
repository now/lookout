# -*- coding: utf-8 -*-

class Lookout::Recorders::State < Lookout::Aphonic
  include Lookout::Recorder

  Error = Class.new(StandardError)

  def initialize(subject, *args)
    super subject
    @methods = Tape.new
    @description = []
    @error = 'expected %p to %s'
    method_missing(*args) unless args.empty?
  end

  def subject!(mocks)
    [@subject, Verify.new(@subject, @methods, @description, @error)]
  end

  private

  # TODO: Why aren’t we recording the block?
  def method_missing(method, *args, &block)
    @description << method.to_s
    args.each{ |arg| @description << arg.inspect }
    @methods.record method, args
    self
  end

  class Verify
    def initialize(subject, methods, description, error)
      @subject, @methods, @description, @error = subject, methods, description, error
    end

    def call
      @methods.play_for(@subject) or
        raise Error, @error % [@subject, @description.join(' ')]
      true
    end
  end
end
