# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls
  Error = Class.new(Lookout::Mock::Error)

  class << self
    def format(limit, calls, format = nil)
      return formats[limit][calls] unless format
      if limit == -1
        formats.default ||= {}
        if calls == -1
          formats.default.default = [format, [:@calls, :@limit]]
        else
          formats.default[calls] = [format, [:@limit]]
        end
      else
        formats[limit] ||= {}
        if calls == -1
          formats[limit].default = [format, [:@calls]]
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

  def initialize(limit)
    @limit = limit
    @calls = 0
  end

  def call
    @calls += 1
    self
  end

  def verify(object, method)
    raise Error, message(object, method) unless satisfied?
    self
  end

  private

  def message(object, method)
    format, variables = self.class.format(@limit, @calls)
    format % ([Lookout::Inspect.new(object, 'object').call, method] +
              variables.map{ |v| instance_variable_get(v) })
  end
end
