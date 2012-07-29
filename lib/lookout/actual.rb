# -*- coding: utf-8 -*-

# Stands in for the actual result of the {Lookout::Expect expect block},
# allowing a query method to call on the actual result to be set up and checked
# after the expect block returns.  Used by
# {Lookout::Expectations::Context#result}.
class Lookout::Actual < Lookout::Aphonic
  # @return [Actual::Not] A result stand-in that’s the inversion of the
  #   receiver
  def not; Lookout::Actual::Not.new end

  # Method for improving readability of query method set-up.
  # @return [self]
  def to; self end

  # Method for improving readability of query method set-up.
  # @return [self]
  def be; self end

  # Method for improving readability of query method set-up.
  # @return [self]
  def have; self end

  private

  # @param (see Method#initialize)
  # @return [Method] A method wrapper that’ll call _method_ with _args_ and
  #   _block_ when called
  def method_missing(method, *args, &block) Method.new(method, *args, &block) end
end
