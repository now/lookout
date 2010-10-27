# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect [?b, 1] do
    result = []
    Lookout::Diff::Algorithm::Difflib::Position::From.new('abc', 1...2).each_with_index do |c, i|
      result = [c, i]
    end
    result
  end

  expect Lookout::Diff::Algorithm::Difflib::Position::From.new('abc', 2...3) do
    Lookout::Diff::Algorithm::Difflib::Position::From.new('abc').begin_at(2)
  end

  expect Lookout::Diff::Algorithm::Difflib::Position::From.new('abc', 0...2) do
    Lookout::Diff::Algorithm::Difflib::Position::From.new('abc').end_at(2)
  end

  expect ?a do
    Lookout::Diff::Algorithm::Difflib::Position::From.new('aba')[0]
  end
end
