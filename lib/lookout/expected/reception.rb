# -*- coding: utf-8 -*-

class Lookout::Expected::Reception < Lookout::Expected::Object
  def initialize(subject, method, calls, *args, &body)
    super subject
    @method, @calls, @args, @body = method, calls, args, body
  end

  def actualize(file, line, &block)
    Lookout::Expect::Reception.new(self, file, line, &block)
  end

  def mock(methods)
    methods.define(subject, @method, @calls, *@args, &@body)
  end
end
