# -*- coding: utf-8 -*-

class Lookout::Mock::Methods < Lookout::Stub::Methods
  class << self
    def during
      methods = new
      begin
        yield(methods)
      rescue
        begin
          methods.undefine
        rescue Lookout::Mock::Method::Calls::Error
        end
        raise
      end.tap{ methods.undefine }
    end
  end

  def define(object, method, calls, *args, &body)
    undefined = Lookout::Mock::Method::Undefined.new(object, method, calls, *args, &body)
    raise RuntimeError,
      'can only mock one method per expectation: mock either %s or %s' %
        [@methods.first, undefined] unless @methods.empty?
    @methods << undefined.define
    self
  end
end
