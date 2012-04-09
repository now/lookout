# -*- coding: utf-8 -*-

# Generates difference reports between {::Object}s.  This is the base
# difference class and should be subclassed unless something more specific fits
# the bill.  The objects are assumed to differ and you’ll surely get confused
# if they don’t.  Determining if the objects do differ is, however, up to the
# caller.
class Lookout::Difference::Object
  # @param [::Object] actual The actual result
  # @param [::Object] expected The expected value
  def initialize(actual, expected)
    @actual, @expected = actual, expected
  end

  # Returns a message explaining how the actual result differs from the
  # expected value.
  # @return [::String] The concatenation of {#inspect_actual}, {#symbol}, and
  #   {#inspect_expected}
  def message
    [inspect_actual, symbol, inspect_expected].join('')
  end

  # Returns an Enumerable over the formatted operations that would have to be
  # applied to {#actual} to get {#expected}.
  # @return [Enumerable<String>] An empty Enumerable unless a subclass manages
  #   to generate a more specific difference report.
  def diff
    []
  end

  # @param [Object] other
  # @return [Boolean] True if the receiver’s class, {#message}, and {#diff}
  #   equal those of _other_
  def ==(other)
    self.class == other.class and
      message == other.message and
      diff.to_s == other.diff.to_s
  end

  # @return [::Object] The actual result
  attr_reader :actual

  # @return [::Object] The expected value
  attr_reader :expected

  private

  # @return [::String] The safely inspected value of {#actual}, see {Inspect}
  def inspect_actual
    Lookout::Inspect::Actual.new(actual).call
  end

  # @return [::String] The safely inspected value of {#expected}, see {Inspect}
  def inspect_expected
    Lookout::Inspect::Expected.new(expected).call
  end

  # @return [::String] The inequality symbol to use (‘≠’)
  def symbol
    '≠'
  end
end
