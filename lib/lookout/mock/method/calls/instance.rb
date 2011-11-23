# -*- coding: utf-8 -*-

module Lookout::Mock::Method::Calls::Instance
  def initialize(method, limit)
    @method, @limit = method, limit
    @calls = 0
  end

  def call
    @calls += 1
    self
  end

  def verify
    raise Lookout::Mock::Method::Calls::Error, message unless satisfied?
    self
  end

  private

  def message
    format, variables = self.class.format(@limit, @calls)
    format % variables.map{ |v| instance_variable_get(v) }
  end
end
