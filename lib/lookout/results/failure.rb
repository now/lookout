# -*- coding: utf-8 -*-

class Lookout::Results::Failure
  include Lookout::Result

  def initialize(file, line, difference)
    super file, line
    @difference = difference
  end

  def ==(other)
    super and difference == other.difference
  end

  def hash
    super ^ difference.hash
  end

  def to_s
    [super, difference_to_s].compact.join(': ')
  end

  protected

  attr_reader :difference

  def difference_to_s
    begin
      m = difference.message
    rescue => e
      raise if difference.class == Lookout::Difference::Object rescue true
      return '%s (cannot generate more specific failure message: %s)' %
        [Lookout::Difference::Object.new(difference.actual,
                                         difference.expected).message,
         e.message]
    end
    begin
      d = difference.diff.to_a.join("\n")
    rescue => e
      d = '(cannot diff expected value and actual result: %s)' % e.message
    end
    d.empty? ? m : (d.include?("\n") ? "%s\n%s" : '%s: %s') % [m, d]
  end
end
