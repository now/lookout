# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Lookout::Diff::Algorithm::Difflib::Position::To.new('abc', 2...3, ?a => [1]) do
    Lookout::Diff::Algorithm::Difflib::Position::To.new('abc', 0...3, ?a => [1]).begin_at(2)
  end

  expect Lookout::Diff::Algorithm::Difflib::Position::To.new('abc', 0...2, ?b => [1]) do
    Lookout::Diff::Algorithm::Difflib::Position::To.new('abc', 0...3, ?b => [1]).end_at(2)
  end

  expect [0, 2] do
    Lookout::Diff::Algorithm::Difflib::Position::To.new('aba', 0...3, ?a => [0, 2]).indexes[?a]
  end

  if ' '[0].is_a? String then
    expect 'a' do
      Lookout::Diff::Algorithm::Difflib::Position::To.new('aba')[0]
    end

    expect 'a' => [0, 2], 'b' => [1] do
      Lookout::Diff::Algorithm::Difflib::Position::To.new('aba').indexes
    end
  else
    expect ?a do
      Lookout::Diff::Algorithm::Difflib::Position::To.new('aba')[0]
    end

    expect ?a => [0, 2], ?b => [1] do
      Lookout::Diff::Algorithm::Difflib::Position::To.new('aba').indexes
    end
  end
end
