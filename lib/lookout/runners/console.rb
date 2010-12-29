# -*- coding: utf-8 -*-

class Lookout::Runners::Console
  def initialize(expectations = Lookout::Expectations.new)
    @expectations = expectations
    @run = true
  end

  def install
    at_exit do
      exit 1 unless @run and @expectations.evaluate.succeeded?
    end
    self
  end

  def expectations_eval(&block)
    @expectations.instance_eval(&block)
  rescue
    @run = false
    raise
  end
end
