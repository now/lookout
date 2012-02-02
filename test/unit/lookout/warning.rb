# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Warning.new('a') == Lookout::Warning.new('a')
  end

  expect true do
    Lookout::Warning.new('a') == Lookout::Warning.new("a\n")
  end

  expect false do
    Lookout::Warning.new('a') == Lookout::Warning.new('b')
  end

  expect false do
    Lookout::Warning.new('a') == Lookout::Warning.new("b\n")
  end

  expect true do
    Lookout::Warning.new('a') === Lookout::Warning.new('/a/b/c:1: warning: a')
  end

  expect true do
    Lookout::Warning.new('a') === Lookout::Warning.new("/a/b/c:1: warning: a\n")
  end

  expect false do
    Lookout::Warning.new('a') === Lookout::Warning.new('/a/b/c:1: warning: b')
  end

  expect false do
    Lookout::Warning.new('a') === Lookout::Warning.new("/a/b/c:1: warning: b\n")
  end

  expect '[-b-]{+a+}' do
    Lookout::Warning.new('a').diff(Lookout::Warning.new("/a/b/c:1: warning: b\n")).to_s
  end

  expect 'warning("this is your final one!")' do
    Lookout::Warning.new('this is your final one!').inspect
  end

  expect 'warning("this is your final one!")' do
    Lookout::Warning.new("this is your final one!\n").inspect
  end
end
