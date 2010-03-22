# -*- coding: utf-8 -*-

class Object
  module MochaExpectsMethod
    define_method :expects, Object.instance_method(:expects)
  end

  module LookoutExpectsMethod
    include MochaExpectsMethod

    def expects(*args)
      Lookout.warn 'expect only one thing per test', caller[2]
      super
    end
  end

  include LookoutExpectsMethod
  include MochaExpectsMethod

  attr_accessor :__which_expects__

  def expects(*args)
    (__which_expects__ or MochaExpectsMethod).instance_method(:expects).bind(self).call(*args)
  end

  def to
    Lookout::Recorder.new(self)
  end

  def not
    Lookout::Not.new(self)
  end

  unless defined? instance_exec
    InstanceExecMethods = Module.new
    include InstanceExecMethods

    def instance_exec(*args, &block)
      begin
        saved_critical, Thread.critical = Thread.critical, true
        n = 0
        n += 1 while respond_to?(name = "__instance_exec#{n}")
        InstanceExecMethods.module_eval{ define_method name, &block }
      ensure
        Thread.critical = saved_critical
      end

      begin
        send(name, *args)
      ensure
        InstanceExecMethods.module_eval{ remove_method name } rescue nil
      end
    end
  end
end
