# -*- coding: utf-8 -*-

# Proxies the actual result of the {Lookout::Expect expect block}.  This allows
# the user to set up a query method that should be invoked on the actual result
# and have that result be checked.  This is used by
# {Lookout::Expectations::Context#result}.
class Lookout::Actual < Lookout::Aphonic
  # @return [Lookout::Actual::Not] A result proxy that is the inversion of the
  #   receiver
  def not
    Lookout::Actual::Not.new
  end

  # Method for improving readability of query method set-up.
  # @return [self]
  def to
    self
  end

  # Method for improving readability of query method set-up.
  # @return [self]
  def be
    self
  end

  # Method for improving readability of query method set-up.
  # @return [self]
  def have
    self
  end

  private

  # @param [Symbol] method
  # @param [Object, …] *args
  # @param [Proc] &block
  # @return [Method] A method wrapper that will invoke _method_ with _args_ and
  #   _block_ when called
  def method_missing(name, *args, &block)
    Method.new(name, *args, &block)
  end
end
