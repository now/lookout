# -*- coding: utf-8 -*-

module Lookout::Mock::Method
  include Lookout::Stub::Method

  class << self
    def build(object, method, *args, body)
      undefined = Undefined.new(object, method, Arguments.new(*args), &body)
      yield undefined
      undefined.define
    end
  end

  def initialize(object, method, args, calls, &body)
    super object, method, &body
    @args, @calls = args, calls
  end

  def to_s
    '%s.%s%p' % [Lookout::Inspect.new(@object, 'object').call, @method, @args]
  end

  private

  def stash
    :"__mocked_method_#{@method}"
  end
end
