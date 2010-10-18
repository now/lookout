# -*- coding: utf-8 -*-

module Lookout::Mock::Method::Calls::Class
  def format(limit, calls, format = nil)
    return formats[limit][calls] unless format
    if limit == -1
      formats.default = Hash.new([format, [:@method, :@expected, :@calls]])
    elsif calls == -1
      formats[limit].default = [format, [:@method, :@calls]]
    else
      formats[limit][calls] = [format, [:@method]]
    end
    self
  end

private

  def formats
    @formats ||= Hash.new{ |hash, key| hash[key] = {} }
  end
end
