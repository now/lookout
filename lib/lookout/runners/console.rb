# -*- coding: utf-8 -*-

module Lookout::Runners::Console
  def self.suite_eval(&block)
    setup
    @suite.instance_eval(&block)
  rescue
    @suite.do_not_run
    raise
  end

  def self.setup
    return if instance_variable_defined? :@suite
    @suite = Lookout::Suite.new
    at_exit do
      exit 1 unless @suite.execute.succeeded?
    end
  end
  private_class_method :setup
end
