# -*- coding: utf-8 -*-

require 'lookout/rake/tasks-1.0'

Expectations do
  expect '-w -Ilib -- %s -rtest-1.0 -- test/unit/test-1.0.rb test/unit/test/version.rb' %
      Lookout::Rake::Tasks::Test::LoaderPath do
    command = nil
    Rake.application = Rake::Application.new
    Lookout::Rake::Tasks::Test.new(:inventory => Inventory.new(1, 0, 0, 'test/lib/test/version.rb')){ |t|
      stub(t).ruby{ |s| command = s }
    }
    Rake.application[:test].invoke
    command
  end

  expect '-w -Ilib -- %s -rtest-1.0 -l123 -- test/unit/test-1.0.rb test/unit/test/version.rb' %
      Lookout::Rake::Tasks::Test::LoaderPath do
    command = nil
    Rake.application = Rake::Application.new
    Lookout::Rake::Tasks::Test.new(:inventory => Inventory.new(1, 0, 0, 'test/lib/test/version.rb')){ |t|
      stub(t).ruby{ |s| command = s }
    }
    with_environment 'LINE' => '123' do
      Rake.application[:test].invoke
    end
    command
  end

  expect '-w -Ilib -- %s -rtest-1.0 -c -- test/unit/test-1.0.rb test/unit/test/version.rb' %
      Lookout::Rake::Tasks::Test::LoaderPath do
    command = nil
    Rake.application = Rake::Application.new
    Lookout::Rake::Tasks::Test.new(:inventory => Inventory.new(1, 0, 0, 'test/lib/test/version.rb')){ |t|
      stub(t).ruby{ |s| command = s }
    }
    Rake.application[:'test:coverage'].invoke
    command
  end

  expect '-w -Ilib -- %s -rtest-1.0 -- test/unit/test-1.0.rb test/unit/test/version.rb' %
      Lookout::Rake::Tasks::Test::LoaderPath do
    with_constant 'Inventory::Rake::Tasks', Module.new do
      stub(Inventory::Rake::Tasks).inventory{
        Inventory.new(1, 0, 0, 'test/lib/test/version.rb')
      }
      stub($LOADED_FEATURES).any?{ true }
      command = nil
      Rake.application = Rake::Application.new
      Lookout::Rake::Tasks::Test.new{ |t|
        stub(t).ruby{ |s| command = s }
      }
      Rake.application[:test].invoke
      command
    end
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
