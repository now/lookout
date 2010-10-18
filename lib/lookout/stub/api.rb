# -*- coding: utf-8 -*-

module Lookout::Stub::API
  def stub(*args)
    raise ArgumentError,
      'wrong number of arguments (%d for 1)' % args.length unless args.count < 2
    args.length > 0 ? MethodRecorder.new(args[0]) : Lookout::Stub::Object.new
  end

  class MethodRecorder < Lookout::Aphonic
    def initialize(object)
      @object = object
    end

    def method_missing(method, &block)
      Lookout::Stub.method(@object, method, &block)
    end
  end
end
