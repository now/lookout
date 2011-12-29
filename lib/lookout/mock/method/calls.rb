# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls
  Error = Class.new(Lookout::Mock::Error)

  class << self
    def format(limit, calls, format = nil)
      return formats[limit][calls] unless format
      if limit == -1
        formats.default ||= {}
        if calls == -1
          formats.default.default = [format, [:calls, :limit]]
        else
          formats.default[calls] = [format, [:limit]]
        end
      else
        formats[limit] ||= {}
        if calls == -1
          formats[limit].default = [format, [:calls]]
        else
          formats[limit][calls] = [format, []]
        end
      end
      self
    end

    private

    def formats
      @formats ||= {}
    end
  end

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

  protected

  attr_reader :object, :method, :limit, :calls
  attr_writer :calls

  private

  def surpassed?
    calls > limit
  end

  def error
    format, variables = self.class.format(limit, calls)
    raise Error, format % ([Lookout::Inspect.new(object, 'object').call, method] +
                           variables.map{ |v| self.send(v) })
  end
end
