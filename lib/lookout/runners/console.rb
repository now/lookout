# -*- coding: utf-8 -*-

module Lookout::Runners::Console
  def self.expectations_eval(&block)
    setup
    @expectations.instance_eval(&block)
  rescue
    @expectations.do_not_run
    raise
  end

  def self.setup
    return if instance_variable_defined? :@expectations
    @expectations = Lookout::Expectations.new
    at_exit do
      exit 1 unless @expectations.execute.succeeded?
    end
  end
  private_class_method :setup
end
