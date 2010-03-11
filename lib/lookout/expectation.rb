# -*- coding: utf-8 -*-

require 'mocha'

class Lookout::Expectation
  include Mocha::API
  attr_accessor :expected, :block, :file, :line, :actual

  def initialize(expected, file, line, &block)
    self.expected, self.block = expected, block
    self.file, self.line = file, line.to_i
    case
      when expected.is_a?(Lookout::Recorder) then extend(Lookout::Expectations::Behavior)
      else extend(Lookout::Expectations::State)
    end
  end

  def mock(*args)
    Lookout::StandardError.print "mock method called from #{caller.first.chomp(":in `__instance_exec0'")}\n"
    super
  end

  def ignore
    stub_everything
  end

  def warn_for_expects
    Object.__which_expects__ = LookoutExpectsMethod
    yield
  ensure
    Object.__which_expects__ = MochaExpectsMethod
  end
end
