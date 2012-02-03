# -*- coding: utf-8 -*-

Expectations do
  expect nil do
    :empty?.to_lookout_expected.difference('')
  end

  expect Lookout::Difference::Symbol.new('a', :empty?, 'empty?', nil) do
    :empty?.to_lookout_expected.difference('a')
  end

  expect Lookout::Difference::Symbol.new('', :not_empty?, 'empty?', 'not') do
    :not_empty?.to_lookout_expected.difference('')
  end

  expect nil do
    :not_empty?.to_lookout_expected.difference('a')
  end

  expect nil do
    :a.to_lookout_expected.difference(:a)
  end

  expect Lookout::Difference::Object.new(:b, :a) do
    :a.to_lookout_expected.difference(:b)
  end
end
