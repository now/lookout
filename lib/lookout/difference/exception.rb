# -*- coding: utf-8 -*-

# Difference reports between {::Exception}s.  The report differs from that of
# {Object} in that it tries to “diff” the exception messages and that it uses
# ‘≉’ instead of ‘≠’ to show that the actual result doesn’t match an expected
# Regexp.
class Lookout::Difference::Exception < Lookout::Difference::Object
  # Initializes a difference report between the _actual_ result and the
  # _expected_ value, where _regexp_ is the {::Regexp} found inside _expected_,
  # if any.
  # @param [::Exception] actual
  # @param [::Exception] expected
  # @param [::Regexp, nil] regexp
  def initialize(actual, expected, regexp = nil)
    @regexp = regexp
    super actual, expected
  end

  # @return [Enumerable<String>, super] The result of {String#diff} between
  #   {#expected}’s message and {#actual}’s message if {#actual} and
  #   {#expected} are of the same class and {#expected} and {#actual}’s
  #   messages are Strings, {super} otherwise
  def diff
    return super unless expected.class == actual.class and
      String === expected.message and
      not @regexp and
      (m = actual.message rescue nil) and
      String === m
    expected.message.to_lookout_expected.difference(m).diff
  end

  private

  # @return [::String, super] A specially crafted inspection String containing
  #   the Regexp if {#expected} contains a Regexp, {super} otherwise
  def inspect_expected; @regexp ? '#<%s: %p>' % [expected.class, @regexp] : super end

  # @return [::String, super] The symbol ‘≉’ if a Regexp was found inside
  #   {#expected}, {super} otherwise
  def symbol; @regexp ? '≉' : super end
end
