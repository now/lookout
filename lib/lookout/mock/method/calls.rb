# -*- coding: utf-8 -*-

module Lookout::Mock::Method::Calls
  Error = Class.new(Lookout::Mock::Error)

  def initialize(object, method, limit)
    @object, @method, @limit = object, method, limit
    @calls = 0
  end

  def call
    self.calls += 1
    error if surpassed?
    self
  end

  def verify
    error unless satisfied?
    self
  end

  def ==(other)
    self.class == other.class and
      object == other.object and
      method == other.method and
      limit == other.limit and
      calls == other.calls
  end

  def to_s
    '%s #%s receipts: %d%s%d' %
      [Lookout::Inspect.new(object, 'object').call,
       method,
       calls,
       (satisfied? and not surpassed?) ? operator : negation,
       limit]
  end

  protected

  attr_reader :object, :method, :limit, :calls
  attr_writer :calls

  private

  def surpassed?
    calls > limit
  end

  def error
    raise Error, self.to_s
  end
end
