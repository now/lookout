# -*- coding: utf-8 -*-

Expectations do
  expect result.empty? do Lookout::Diff::Slice.new('') end
  expect result.empty? do Lookout::Diff::Slice.new('a', 0..-1) end
  expect result.empty? do Lookout::Diff::Slice.new('a', 0...0) end
  expect result.not.empty? do Lookout::Diff::Slice.new('a', 0..0) end

  expect 0 do Lookout::Diff::Slice.new('').size end
  expect 0 do Lookout::Diff::Slice.new('a', 0...0).size end
  expect 1 do Lookout::Diff::Slice.new('a', 0..0).size end

  expect false do
    Lookout::Diff::Slice.new('a', 0..0).begin_before? Lookout::Diff::Slice.new('a', 0..1)
  end

  expect true do
    Lookout::Diff::Slice.new('a', 0..0).begin_before? Lookout::Diff::Slice.new('a', 1..1)
  end

  expect false do
    Lookout::Diff::Slice.new('a', 0..0).end_after? Lookout::Diff::Slice.new('a', 0..1)
  end

  expect true do
    Lookout::Diff::Slice.new('a', 1..1).end_after? Lookout::Diff::Slice.new('a', 0..0)
  end

  expect Lookout::Diff::Slice.new('abc', 2..2) do
    Lookout::Diff::Slice.new('abc').begin_after(Lookout::Diff::Slice.new('abc', 0..1))
  end

  expect Lookout::Diff::Slice.new('abc', 0..0) do
    Lookout::Diff::Slice.new('abc').end_before(Lookout::Diff::Slice.new('abc', 1..2))
  end

  expect Lookout::Diff::Slice.new('abc', 1..2) do
    Lookout::Diff::Slice.new('abc').at(1..2)
  end

  expect 'a' do
    Lookout::Diff::Slice.new(%w[a b c])[0]
  end

  expect 'b' do
    Lookout::Diff::Slice.new(%w[a b c], 2..2)[1]
  end

  expect ['b', 1] do
    result = []
    Lookout::Diff::Slice.new(%w[a b c], 1..1).each_with_index do |c, i|
      result = [c, i]
    end
    result
  end
end
