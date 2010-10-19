# -*- coding: utf-8 -*-

module Lookout::Mock
  autoload :Method, 'lookout/mock/method'
  autoload :Methods, 'lookout/mock/methods'
  autoload :Object, 'lookout/mock/object'

  Error = Class.new(StandardError)

  class << self
    def methods
      methods = Methods.new
      yield methods
    ensure
      methods.undefine if methods
    end
  end
end
