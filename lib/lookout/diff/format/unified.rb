# -*- coding: utf-8 -*-

class Lookout::Diff::Format::Unified
  include Enumerable

  # TODO: Format shouldn’t have access to from and to.  Operations should be
  # referencing these objects.
  def initialize(groups)
    @groups = groups
  end

  def each
    @groups.each do |operations|
      group = Group.new(operations)
      yield group.to_s unless group.empty?
    end
    self
  end

private

  class Group
    def initialize(operations)
      @operations = operations
    end

    def empty?
      @operations.size == 1 and @operations.first.parity?
    end

    def delete(operation)
      mark('-', operation.from)
    end

    def equal(operation)
      mark(' ', operation.from)
    end

    def insert(operation)
      mark('+', operation.to)
    end

    def replace(operation)
      delete(operation).concat(insert(operation))
    end

    def to_s
      lines = ['@@ -%d,%d +%d,%d @@' %
               [@operations.first.from.begin + 1,
                @operations.last.from.end - @operations.first.from.begin + 1,
                @operations.first.to.begin + 1,
                @operations.last.to.end - @operations.first.to.begin + 1]]
      @operations.each do |operation|
        lines.concat operation.apply(self)
      end
      lines.join("\n")
    end

  private

    def mark(mark, range)
      range.map{ |item| '%s%s' % [mark, item] }
    end
  end
end
