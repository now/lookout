# -*- coding: utf-8 -*-

# Inverts {Actual}.  Allows a query method to call on the actual result to be
# set up and its inversion checked after the expect block returns.
class Lookout::Actual::Not < Lookout::Actual
  # @return [Actual] A result stand-in that’s the inversion of the receiver
  def not; Lookout::Actual.new end

  private

  # (see Lookout::Actual#method_missing)
  def method_missing(method, *args, &block); Method.new(method, *args, &block) end
end
