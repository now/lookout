# -*- coding: utf-8 -*-

class Lookout::Recorders::State < Lookout::Aphonic
  include Lookout::Recorder

  Error = Class.new(StandardError)

  def initialize(subject, *args)
    super subject
    @methods = Tape.new
    @description = []
    method_missing(*args) unless args.empty?
  end

  def subject!(mocks)
    [@subject, Verify.new(@subject, @methods, @description)]
  end

  private

  # TODO: Why aren’t we recording the block?
  def method_missing(method, *args, &block)
    @description << method.to_s
    args.each{ |arg| @description << arg.inspect }
    @methods.record method, args
    self
  end
end
