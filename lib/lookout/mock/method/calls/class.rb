# -*- coding: utf-8 -*-

module Lookout::Mock::Method::Calls::Class
  def format(limit, calls, format = nil)
    return formats[limit][calls] unless format
    if limit == -1
      @formats.default ||= {}
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
