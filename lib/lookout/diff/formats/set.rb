# -*- coding: utf-8 -*-

# Formats {Lookout::Diff::Operation}s on an undordered set.  This is used by
# {Lookout::Difference::Hash}.  Added ranges of elements are shown having each
# element prefixed by “+” and deleted ranges of elements by “-”.  Replaced
# ranges are shown as a deleted range followed by an added range.
class Lookout::Diff::Formats::Set
  include Enumerable

  # Initializes the set format.
  #
  # @param [Lookout::Diff::Operations] Operations to format
  def initialize(operations)
    @operations = operations
  end

  # Enumerates the formatted operations.
  #
  # @yieldparam string [String] Formatted operation
  # @return [Lookout::Diff::Formats::Set] self
  # @return [Enumerator] An Enumerator over the formatted operations, if no
  #   block given
  def each
    return enum_for(__method__) unless block_given?
    @operations.each do |op|
      operation = Operation.new(op)
      yield operation.to_s unless operation.empty?
    end
    self
  end

  # Concatenates the formatted operations into a single String.
  #
  # @return [String] The String concatenation of the formatted operations
  def to_s
    to_a.join("\n")
  end

  private

  # @private
  class Operation
    def initialize(operation)
      @lines = operation.apply(self)
    end

    def empty?
      @lines.nil?
    end

    def delete(operation)
      mark('-', operation.from)
    end

    def equal(operation)
    end

    def insert(operation)
      mark('+', operation.to)
    end

    def replace(operation)
      delete(operation) + insert(operation)
    end

    def to_s
      @lines.join("\n")
    end

    private

    def mark(mark, range)
      range.map{ |item| '%s%s' % [mark, item] }
    end
  end
end
