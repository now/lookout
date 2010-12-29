# -*- coding: utf-8 -*-

class Lookout::Runners::Console
  def initialize
    @expectations = Lookout::Expectations.new
  end

  def install
    at_exit do
      exit 1 unless @expectations.execute.succeeded?
    end
    self
  end

  def expectations_eval(&block)
    @expectations.instance_eval(&block)
  rescue
    @expectations.do_not_run
    raise
  end
end
