# -*- coding: utf-8 -*-

# A failed result used when the actual result of an expect block exhibits
# differences from the expected value.
class Lookout::Results::Failure
  include Lookout::Result

  # (see Result#initialize)
  # The _difference_ report between the actual result and the expected value
  # will be used to display this information to the user.
  # @param [Difference::Object] difference
  Value(:file, :line, :difference, :comparable => [:file, :line])

  def to_s
    [super, difference_to_s].join(': ')
  end

  private

  def difference_to_s
    begin
      m = difference.message
    rescue => e
      raise if difference.class == Lookout::Difference::Object rescue true
      return '%s (cannot generate more specific failure message: %s)' %
        [Lookout::Difference::Object.new(difference.actual,
                                         difference.expected).message,
         e]
    end
    begin
      d = difference.diff.to_a.join("\n")
    rescue => e
      d = '(cannot diff expected value and actual result: %s)' % e
    end
    d.empty? ? m : (d.include?("\n") ? "%s\n%s" : '%s: %s') % [m, d]
  end
end
