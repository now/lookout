# -*- coding: utf-8 -*-

module Lookout::Stub
#  autoload :API, 'lookout/stub/api'
  autoload :Method, 'lookout/stub/method'
  autoload :Methods, 'lookout/stub/methods'
  autoload :Object, 'lookout/stub/object'

  class << self
    def bing
      methods = Methods.new
      yield methods
    ensure
      methods.undefine
    end
  end
end
