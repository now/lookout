# -*- coding: utf-8 -*-

# Warning expectation proxy.  Used to expect warning outputs during the
# execution of the {Lookout::Expect expect block}.  Warnings are matched by
# ignoring any trailing newlines and by removing any file/line warning
# prefixes.  This is done as Ruby internally uses two different functions to
# generate warnings (rb_warn() and rb_warning()).
class Lookout::Warning < Lookout::Output
  # Proxies the _expected_ warning output.
  # @param (see Output#initialize)
  def initialize(expected) super expected.chomp end

  # @return True if the receiver `#==` _other_ or if their classes and
  #   normalized expected output `#==` each other
  def ===(other)
    self == other or
      (self.class == other.class and normalized == other.normalized)
  end

  def inspect; 'warning(%p)' % expected end

  # @return [Enumerable<String>] An Enumerable over the formatted operations
  #   that would have to be applied to the actual warning output to get the
  #   expected warning output after any normalization of the warning outputs
  #   have been performed
  def diff(other)
    self == normalized ? super(other.normalized) : normalized.diff(other)
  end

  # @return [Expected::Lookout::Warning] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected; Lookout::Expected::Lookout::Warning.new(self) end

  protected

  def normalized
    normalized = expected.sub(/\A.*?:\d+: warning: /, '')
    expected == normalized ? self : self.class.new(normalized)
  end
end
