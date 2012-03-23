# -*- coding: utf-8 -*-

# Formats {Lookout::Diff::Operation}s inline in a String.  Additions are shown
# as `{+…+}` and deletions as `[-…-]`.  Replacements are shown as a deletion
# followed by an insertion.
#
# This format is used by {Lookout::Difference::String} for single-line Strings.
class Lookout::Diff::Formats::Inline
  include Enumerable

  # Initializes the inline format.
  #
  # @param [Lookout::Diff::Operations] Operations to format
  def initialize(operations)
    @to_s = ToS.new(operations).to_s
  end

  # Enumerates the formatted operations.
  #
  # @yieldparam string [String] Formatted operation
  # @return [Lookout::Diff::Formats::Inline] self
  # @return [Enumerator] An Enumerator over the formatted operations, if no
  #   block given
  def each
    return enum_for(__method__) unless block_given?
    yield to_s
    self
  end

  # Concatenates the formatted operations into a single String.
  #
  # @return [String] The String concatenation of the formatted operations
  def to_s
    @to_s
  end

  private

  # @private
  class ToS
    def initialize(operations)
      @to_s = operations.map{ |o| o.apply(self) }.join('').freeze
    end

    def delete(operation)
      '[-%s-]' % operation.from.to_items
    end

    def equal(operation)
      operation.from.to_items
    end

    def insert(operation)
      '{+%s+}' % operation.to.to_items
    end

    def replace(operation)
      delete(operation) + insert(operation)
    end

    def to_s
      @to_s
    end
  end
end
