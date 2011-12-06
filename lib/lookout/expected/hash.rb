# -*- coding: utf-8 -*-

class Lookout::Expected::Hash < Lookout::Expected::Object
  def =~(other)
    return false unless Hash === other and subject.size == other.size
    subject.all?{ |key, value| value.to_lookout_expected =~ other[key] }
  end

  def diff(other)
    return if subject.size == 1 or not Hash === other
    Lookout::Diff::Formats::Hash.
      new(Lookout::Diff::Operations.
            new(Lookout::Diff::Algorithms::Difflib.
                  new(array(other), array(subject)))).to_a.join("\n")
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
