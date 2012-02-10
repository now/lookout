# -*- coding: utf-8 -*-

class Lookout::Actual::Not < Lookout::Actual
  def not
    Lookout::Actual.new
  end

  private

  def method_missing(method, *args, &block)
    Method.new(method, *args, &block)
  end
end
