# -*- coding: utf-8 -*-

module Lookout::Stub
  autoload :API, 'lookout/stub/api'
  autoload :Method, 'lookout/stub/method'
  autoload :Methods, 'lookout/stub/methods'
  autoload :Object, 'lookout/stub/object'

  class << self
    include API

    def method(object, method, &block)
      Method.new(object, method, &block).tap{ |m| methods << m }
    end

  private

    def methods
      @methods ||= Methods.new
    end
  end
end
