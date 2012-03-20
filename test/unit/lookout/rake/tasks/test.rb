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

  expect '-w -Ilib -- %s -rtest -l123 -- test/unit/test.rb test/unit/test/version.rb' %
      Lookout::Rake::Tasks::Test::LoaderPath do
    command = nil
    Rake.application = Rake::Application.new
    Lookout::Rake::Tasks::Test.new(:inventory => Inventory.new(0, 1, 0, 'test/lib/test/version.rb')){ |t|
      stub(t).ruby{ |s| command = s }
    }
    saved_line = ENV['line']
    ENV['line'] = '123'
    begin
      Rake.application[:test].invoke
    ensure
      ENV['line'] = saved_line
    end
    command
  end

  expect '-w -Ilib -- %s -rtest -c -- test/unit/test.rb test/unit/test/version.rb' %
      Lookout::Rake::Tasks::Test::LoaderPath do
    command = nil
    Rake.application = Rake::Application.new
    Lookout::Rake::Tasks::Test.new(:inventory => Inventory.new(0, 1, 0, 'test/lib/test/version.rb')){ |t|
      stub(t).ruby{ |s| command = s }
    }
    Rake.application[:'test:coverage'].invoke
    command
  end

  expect '-w -Ilib -- %s -rtest -- test/unit/test.rb test/unit/test/version.rb' %
      Lookout::Rake::Tasks::Test::LoaderPath do
    tasks = stub(:name => 'Inventory::Rake::Tasks',
                 :inventory => Inventory.new(0, 1, 0, 'test/lib/test/version.rb'))
    rake = stub(:const_get => tasks)
    inventory = stub(:const_get => rake)
    stub(Object).const_get{ inventory }
    command = nil
    Rake.application = Rake::Application.new
    Lookout::Rake::Tasks::Test.new{ |t|
      stub(t).ruby{ |s| command = s }
    }
    Rake.application[:test].invoke
    command
  end

  expect RuntimeError.new(/\Agem specification was not given/) do
    stub(Dir).[]{ [] }
    Rake.application = Rake::Application.new
    Lookout::Rake::Tasks::Test.new
    Rake.application[:test].invoke
    command
  end

  expect '-w -Ilib -- %s -rtest -- test/unit/test.rb test/unit/test/version.rb' %
      Lookout::Rake::Tasks::Test::LoaderPath do
    stub(Dir).[]{ %w'test.gemspec' }
    stub(Gem::Specification).load{ Gem::Specification.new{ |s| s.name = 'test' } }
    command = nil
    Rake.application = Rake::Application.new
    Lookout::Rake::Tasks::Test.new(:files => %w'test/unit/test.rb test/unit/test/version.rb'){ |t|
      stub(t).ruby{ |s| command = s }
    }
    Rake.application[:test].invoke
    command
  end

  expect '-w -Ilib -- %s -rtest -- test/unit/test.rb test/unit/test/version.rb' %
      Lookout::Rake::Tasks::Test::LoaderPath do
    command = nil
    Rake.application = Rake::Application.new
    Lookout::Rake::Tasks::Test.new(:specification => Gem::Specification.new{ |s|
                                     s.name = 'test'
                                   },
                                   :files => %w'test/unit/test.rb test/unit/test/version.rb'){ |t|
      stub(t).ruby{ |s| command = s }
    }
    Rake.application[:test].invoke
    command
  end

  expect %w'lib' do
    stub(Dir).[]{ %w'test.gemspec' }
    stub(Gem::Specification).load{ Gem::Specification.new{ |s| s.name = 'test' } }
    Rake.application = Rake::Application.new
    Lookout::Rake::Tasks::Test.new(:paths => nil,
                                   :files => %w'test/unit/test.rb test/unit/test/version.rb').paths
  end

  expect %w'test' do
    stub(Dir).[]{ %w'test.gemspec' }
    stub(Gem::Specification).load{ Gem::Specification.new{ |s| s.name = 'test' } }
    Rake.application = Rake::Application.new
    Lookout::Rake::Tasks::Test.new(:paths => nil,
                                   :files => %w'test/unit/test.rb test/unit/test/version.rb').requires
  end
end
