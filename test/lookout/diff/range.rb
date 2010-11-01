# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Lookout::Diff::Range.new('').to.be.empty?
  expect Lookout::Diff::Range.new('a', 0..-1).to.be.empty?
  expect Lookout::Diff::Range.new('a', 0...0).to.be.empty?
  expect Lookout::Diff::Range.new('a', 0..0).not.to.be.empty?

  expect Lookout::Diff::Range.new('').to.have.size.equal?(0)
  expect Lookout::Diff::Range.new('a', 0...0).to.have.size.equal?(0)
  expect Lookout::Diff::Range.new('a', 0..0).to.have.size.equal?(1)

  expect Lookout::Diff::Range.new('a', 0..0).not.to.be.
    begins_before?(Lookout::Diff::Range.new('a', 0..1))
  expect Lookout::Diff::Range.new('a', 0..0).to.be.
    begins_before?(Lookout::Diff::Range.new('a', 1..1))

  expect Lookout::Diff::Range.new('a', 0..0).not.to.be.
    ends_after?(Lookout::Diff::Range.new('a', 0..1))
  expect Lookout::Diff::Range.new('a', 1..1).to.be.
    ends_after?(Lookout::Diff::Range.new('a', 0..0))

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
