# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::Reception < Lookout::Expected::Object
  def initialize(subject, method, calls, *args, &body)
    super subject
    @method, @calls, @args, @body = method, calls, args, body
  end

  def expect(file, line, &block)
    Lookout::Expect::Lookout::Reception.new(self, file, line, &block)
  end

  def define(methods)
    methods.define(subject, @method, @calls, *@args, &@body)
    self
  end
end
