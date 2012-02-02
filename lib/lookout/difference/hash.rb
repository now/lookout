# -*- coding: utf-8 -*-

class Lookout::Difference::Hash < Lookout::Difference::Object
  def diff
    return super if @expected.size == 1 or not ::Hash === @actual
    ::Lookout::Diff::Formats::Set.
      new(::Lookout::Diff::Operations.
            new(::Lookout::Diff::Algorithms::Difflib.
                  new(array(@actual), array(@expected))))
  end

  def array(hash)
    hash.to_a.sort_by{ |key, _| key }.map{ |key, value|
      '%s => %s' %
        [::Lookout::Inspect.new(key, 'key').call,
         ::Lookout::Inspect.new(value, 'value').call]
    }
  end
end
