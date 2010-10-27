# -*- coding: utf-8 -*-

class Lookout::Diff::Format::Inline
  class << self
    def diff(from, to, &is_junk)
      new(from, to, Lookout::Diff::Operations.diff(from, to, &is_junk)).to_s
    end
  end

  def initialize(from, to, operations)
    @to_s = ToS.new(from, to, operations).to_s
  end

  def to_s
    @to_s
  end

private

  class ToS
    def initialize(from, to, operations)
      @from, @to = from, to
      @to_s = operations.same? ? '' : operations.map{ |o| o.apply(self) }.join('')
    end

    def delete(operation)
      '[-%s-]' % @from[operation.from]
    end

    def equal(operation)
      @from[operation.from]
    end

    def insert(operation)
      '{+%s+}' % @to[operation.to]
    end

    def replace(operation)
      delete(operation) + insert(operation)
    end

    def to_s
      @to_s
    end
  end
end
