# -*- coding: utf-8 -*-

class Lookout::Expected::Hash < Lookout::Expected::Object
  def =~(other)
    return false unless Hash === other and @expected.size == other.size
    @expected.all?{ |key, value| Lookout::Equality.equal? value, other[key] }
  end

  def diff(other)
    return if @expected.size == 1 or not Hash === other
    Lookout::Diff::Formats::Hash.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithms::Difflib.
                  new(array(other), array(@expected)))).to_a.join("\n")
  end

  private

  def array(hash)
    hash.to_a.sort_by{ |key, _| key }.map{ |key, value|
      '%s => %s' %
        [Lookout::Inspect.new(key, 'key').call,
         Lookout::Inspect.new(value, 'value').call]
    }
  end
end
