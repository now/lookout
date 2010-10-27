# -*- coding: utf-8 -*-

module Lookout
  autoload :Aphonic, 'lookout/aphonic'
  autoload :Diff, 'lookout/diff'
  autoload :Equality, 'lookout/equality'
  autoload :Expectation, 'lookout/expectation'
  autoload :Expectations, 'lookout/expectations'
  autoload :Mock, 'lookout/mock'
  autoload :Recorder, 'lookout/recorder'
  autoload :Recorders, 'lookout/recorders'
  autoload :Result, 'lookout/result'
  autoload :Results, 'lookout/results'
  autoload :Runners, 'lookout/runners'
  autoload :Stub, 'lookout/stub'
  autoload :Suite, 'lookout/suite'
  autoload :UI, 'lookout/ui'
  autoload :Utilities, 'lookout/utilities'
  autoload :Version, 'lookout/version'
  autoload :XML, 'lookout/xml'
end

require 'lookout/object'

def Expectations(&block)
  Lookout::Runners::Console.suite_eval(&block)
end
