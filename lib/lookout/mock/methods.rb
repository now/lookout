# -*- coding: utf-8 -*-

class Lookout::Mock::Methods < Lookout::Stub::Methods
  def define(object, method, *args, body)
    Lookout::Mock::Method.build(object, method, *args, body){ |undefined|
      raise RuntimeError,
        'can only mock one method per expectation: mock either %s or %s' %
          [@methods.first, undefined] unless @methods.empty?
      yield undefined
    }.tap{ |defined| @methods << defined }
  end
end
