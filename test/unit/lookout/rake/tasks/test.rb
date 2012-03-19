# -*- coding: utf-8 -*-

require 'lookout/rake/tasks'

Expectations do
  expect '-w -Ilib -- %s -rtest -- test/unit/test.rb test/unit/test/version.rb' %
      Lookout::Rake::Tasks::Test::LoaderPath do
    command = nil
    Rake.application = Rake::Application.new
    Lookout::Rake::Tasks::Test.new(:inventory => Inventory.new(0, 1, 0, 'test/lib/test/version.rb')){ |t|
      stub(t).ruby{ |s| command = s }
    }
    Rake.application[:test].invoke
    command
  end

  expect RuntimeError.new(/\Agem specification was not given/) do
    Rake.application = Rake::Application.new
    Lookout::Rake::Tasks::Test.new
    Rake.application[:test].invoke
    command
  end
end
