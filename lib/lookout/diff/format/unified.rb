# -*- coding: utf-8 -*-

class Lookout::Diff::Format::Unified
  include Enumerable

  class << self
    def diff(from, to, context = 3, &is_junk)
      new(from, to, Lookout::Diff::Groups.diff(from, to, context, &is_junk))
    end
  end

  # TODO: Format shouldn’t have access to from and to.  Operations should be
  # referencing these objects.
  def initialize(from, to, groups)
    @from, @to, @groups = from, to, groups
  end

  def each
    return self if @groups.same?
    @groups.each do |operations|
      yield Group.new(@from, @to, operations).to_s
    end
    self
  end

private

  class Group
    def initialize(from, to, operations)
      @from, @to = from, to
      @lines = ['@@ -%d,%d +%d,%d @@' %
                [operations.first.from.begin + 1,
                 operations.last.from.end - operations.first.from.begin,
                 operations.first.to.begin + 1,
                 operations.last.to.end - operations.first.to.begin]]
      operations.each do |operation|
        @lines.concat operation.apply(self)
      end
    end

    def delete(operation)
      mark('-', @from[operation.from])
    end

    def equal(operation)
      mark(' ', @from[operation.from])
    end

    def insert(operation)
      mark('+', @to[operation.to])
    end

    def replace(operation)
      delete(operation).concat(insert(operation))
    end

    def to_s
      @lines.join("\n")
    end

  private

    def mark(mark, items)
      items.map{ |item| '%s%s' % [mark, item] }
    end
  end
end
