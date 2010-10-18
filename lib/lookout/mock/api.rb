# -*- coding: utf-8 -*-

module Lookout::Mock::API
  def mock(*args)
    raise ArgumentError,
      'wrong number of arguments (%d for 1)' % args.length unless args.length < 2
    args.length > 0 ? MethodRecorder.new(args[0]) : Lookout::Mock::Object.new
  end

  class MethodRecorder < Lookout::Aphonic
    def initialize(object)
      @object = object
    end

    def method_missing(method, *args, &block)
      Lookout::Mock.method(@object, method, *args, &block)
    end
  end
end
