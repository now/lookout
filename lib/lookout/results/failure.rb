# -*- coding: utf-8 -*-

# A failed result used when the actual result of an expect block exhibits
# differences from the expected value.
class Lookout::Results::Failure
  include Lookout::Result

  # (see Result#initialize)
  # The _difference_ report between the actual result and the expected value
  # will be used to display this information to the user.
  # @param [Difference::Object] difference
  def initialize(file, line, difference)
    super file, line
    @difference = difference
  end

  # @param [Failure] other
  # @return [Boolean] True if the receiver’s class, {#file}, {#line} and
  #   difference report `#==` that of _other_
  def ==(other)
    super and difference == other.difference
  end

  def hash
    super ^ difference.hash
  end

  def to_s
    [super, difference_to_s].join(': ')
  end

  protected

  attr_reader :difference

  private

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
    return 'the actual result differed from the expected value when the
            expectation was executed, but now either one or both have changed
            in a way that they now no longer appear different, possibly due to
            timing-dependent or interoperating expectations; to get a
            meaningful difference report, make sure that these values don’t
            change after the expectation is executed'.gsub(/\n\s+/, ' ') if m.empty?
    begin
      d = difference.diff.to_a.join("\n")
    rescue => e
      d = '(cannot diff expected value and actual result: %s)' % e.message
    end
    d.empty? ? m : (d.include?("\n") ? "%s\n%s" : '%s: %s') % [m, d]
  end
end
