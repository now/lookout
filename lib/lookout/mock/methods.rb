# -*- coding: utf-8 -*-

class Lookout::Mock::Methods < Lookout::Stub::Methods
  class << self
    def with_verification
      methods = new
      begin
        result = yield(methods)
        methods.verify
      ensure
        methods.undefine
      end
      result
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

  def verify
    @methods.each(&:verify)
    self
  end
end
