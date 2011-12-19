# -*- coding: utf-8 -*-

module Lookout::Mock::Method
  def initialize(object, method, calls, *args, &body)
    super object, method, &body
    @calls, @args = calls.bind(self), Arguments.new(*args)
  end

  def to_s
    '%s.%s%p' % [Lookout::Inspect.new(@object, 'object').call, @method, @args]
  end

  private

  def stash
    :"__mocked_method_#{@method}"
  end
end
