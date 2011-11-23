# -*- coding: utf-8 -*-

class Lookout::Diff::Formats::Hash
  include Enumerable

  def initialize(operations)
    @operations = operations
  end

  def each
    @operations.each do |op|
      operation = Operation.new(op)
      yield operation.to_s unless operation.empty?
    end
  end

  private

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
