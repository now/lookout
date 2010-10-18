# -*- coding: utf-8 -*-

module Lookout::Mock
  autoload :API, 'lookout/mock/api'
  autoload :Method, 'lookout/mock/method'
  autoload :Methods, 'lookout/mock/methods'
  autoload :Object, 'lookout/mock/object'

  Error = Class.new(StandardError)

  class << self
    include API

    def ing(&block)
      instance_eval(&block).tap{ verify }
    ensure
      reset
    end

    # TODO: Only allow one method to be mocked.  We only want one thing to be
    # verified in each test, so that makes sense.
    def method(object, method, *args, &block)
      Method.new(object, method, *args, &block).tap{ |m| methods << m }
    end

    def verify
      methods.verify
    end

    def reset
      @methods = Methods.new
    end

  private

    def methods
      @methods ||= Methods.new
    end
  end
end
