# -*- coding: utf-8 -*-

class Lookout::Actual < Lookout::Aphonic
  def not
    Lookout::Actual::Not.new
  end

  def to
    self
  end

  def be
    self
  end

  def have
    self
  end

  private

  def method_missing(method, *args, &block)
    Method.new(method, *args, &block)
  end
end
