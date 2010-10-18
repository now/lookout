# -*- coding: utf-8 -*-

class Object
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
