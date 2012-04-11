# -*- coding: utf-8 -*-

# Inverts {Lookout::Actual}.  This allows the user to set up a query method
# that should be invoked on the actual result and have the inversion of that
# result be checked.
class Lookout::Actual::Not < Lookout::Actual
  # @return [Lookout::Actual] A result proxy that is the inversion of the
  #   receiver
  def not
    Lookout::Actual.new
  end

  private

  # (see Lookout::Actual#method_missing)
  def method_missing(method, *args, &block)
    Method.new(method, *args, &block)
  end
end
