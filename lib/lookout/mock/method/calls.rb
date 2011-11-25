# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Calls
  Error = Class.new(Lookout::Mock::Error)

  class << self
    def format(limit, calls, format = nil)
      return formats[limit][calls] unless format
      if limit == -1
        formats.default ||= {}
        if calls == -1
          formats.default.default = [format, [:@method, :@limit, :@calls]]
        else
          formats.default[calls] = [format, [:@method, :@limit]]
        end
      else
        formats[limit] ||= {}
        if calls == -1
          formats[limit].default = [format, [:@method, :@calls]]
        else
          formats[limit][calls] = [format, [:@method]]
        end
      end
      self
    end

    private

    def formats
      @formats ||= {}
    end
  end

  def initialize(method, limit)
    @method, @limit = method, limit
    @calls = 0
  end

  def call
    @calls += 1
    self
  end

  def verify
    raise Error, message unless satisfied?
    self
  end

  private

  def message
    format, variables = self.class.format(@limit, @calls)
    format % variables.map{ |v| instance_variable_get(v) }
  end
end
