# -*- coding: utf-8 -*-

class Lookout::Diff::Format::Inline
  class << self
    def diff(from, to, &is_junk)
      new(Lookout::Diff::Operations.diff(from, to, &is_junk)).to_s
    end
  end

  def initialize(operations)
    @to_s = ToS.new(operations).to_s
  end

  def to_s
    @to_s
  end

private

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
