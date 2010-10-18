# -*- coding: utf-8 -*-

module Lookout::Mock
  autoload :Method, 'lookout/mock/method'
  autoload :Methods, 'lookout/mock/methods'
  autoload :Object, 'lookout/mock/object'

  Error = Class.new(StandardError)

  # TODO: Rename to Methods.
  class Store
    def initialize
      @method = nil
    end

    def define(object, method, *args, &block)
      # TODO: Improve on this error class/message.
      raise RuntimeError, 'mock already established' if defined? @method and @method
      @method = Method.new(object, method, *args, &block).define
    end

    def verify
      @method.verify if @method
      self
    end

    def undefine
      @method.undefine if @method
      self
    end
  end

  class << self
    def ing
      store = Store.new
      yield store
    ensure
      store.undefine
    end
  end
end
