# -*- coding: utf-8 -*-

# Warning expectation proxy.  Used to expect warning outputs during the
# execution of the {Lookout::Expect expect block}.  Warnings are matched by
# ignoring any trailing newlines and by removing any file/line warning
# prefixes.  This is done as Ruby internally uses two different functions to
# generate warnings (rb_warn() and rb_warning()).
class Lookout::Warning < Lookout::Output
  # @param [String] output The expected warning output
  def initialize(output)
    super output.chomp
  end

  # @param [Warning] other
  # @return [Boolean] True if the receiver `#==` _other_ or if their classes
  #   and normalized output `#==` each other
  def ===(other)
    self == other or
      (self.class == other.class and normalized == other.normalized)
  end

  def inspect
    'warning(%p)' % output
  end

  # @param [Output] other
  # @return [Enumerable] An Enumerabel over the formatted operations that would
  #   have to be applied to the actual warning output to get the expected
  #   warning output after any normalization of the warning outputs have been
  #   performed
  def diff(other)
    self == normalized ? super(other.normalized) : normalized.diff(other)
  end

  # @return [Expected::Lookout::Warning] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected
    Lookout::Expected::Lookout::Warning.new(self)
  end

  protected

  def normalized
    normalized = output.sub(/\A.*?:\d+: warning: /, '')
    output == normalized ? self : self.class.new(normalized)
  end
end
