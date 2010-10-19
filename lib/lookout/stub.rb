# -*- coding: utf-8 -*-

module Lookout::Stub
  autoload :Method, 'lookout/stub/method'
  autoload :Methods, 'lookout/stub/methods'
  autoload :Object, 'lookout/stub/object'

  class << self
    def methods
      methods = Methods.new
      yield methods
    ensure
      methods.undefine if methods
    end
  end
end
