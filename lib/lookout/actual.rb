# -*- coding: utf-8 -*-

class Lookout::Actual < Lookout::Aphonic
  def initialize
    @methods = Lookout::Actual::Methods.new
  end

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

  def to_lookout_expected
    Lookout::Expected::Lookout::Actual.new(@methods)
  end

  private

  def method_missing(method, *args, &block)
    @methods.push method, *args, &block
    self
  end
end
