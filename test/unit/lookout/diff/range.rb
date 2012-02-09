# -*- coding: utf-8 -*-

Expectations do
  expect result.empty? do Lookout::Diff::Range.new('') end
  expect result.empty? do Lookout::Diff::Range.new('a', 0..-1) end
  expect result.empty? do Lookout::Diff::Range.new('a', 0...0) end
  expect result.not.empty? do Lookout::Diff::Range.new('a', 0..0) end

  expect 0 do Lookout::Diff::Range.new('').size end
  expect 0 do Lookout::Diff::Range.new('a', 0...0).size end
  expect 1 do Lookout::Diff::Range.new('a', 0..0).size end

  expect false do
    Lookout::Diff::Range.new('a', 0..0).begins_before? Lookout::Diff::Range.new('a', 0..1)
  end

  expect true do
    Lookout::Diff::Range.new('a', 0..0).begins_before? Lookout::Diff::Range.new('a', 1..1)
  end

  expect false do
    Lookout::Diff::Range.new('a', 0..0).ends_after? Lookout::Diff::Range.new('a', 0..1)
  end

  expect true do
    Lookout::Diff::Range.new('a', 1..1).ends_after? Lookout::Diff::Range.new('a', 0..0)
  end

  expect Lookout::Diff::Range.new('abc', 2..2) do
    Lookout::Diff::Range.new('abc').begin_after(Lookout::Diff::Range.new('abc', 0..1))
  end

  expect Lookout::Diff::Range.new('abc', 0..0) do
    Lookout::Diff::Range.new('abc').end_before(Lookout::Diff::Range.new('abc', 1..2))
  end

  expect Lookout::Diff::Range.new('abc', 1..2) do
    Lookout::Diff::Range.new('abc').at(1..2)
  end

  expect 'a' do
    Lookout::Diff::Range.new(%w[a b c])[0]
  end

  expect 'b' do
    Lookout::Diff::Range.new(%w[a b c], 2..2)[1]
  end

  expect ['b', 1] do
    result = []
    Lookout::Diff::Range.new(%w[a b c], 1..1).each_with_index do |c, i|
      result = [c, i]
    end
    result
  end
end
