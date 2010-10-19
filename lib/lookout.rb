# -*- coding: utf-8 -*-

module Lookout
  autoload :Aphonic, 'lookout/aphonic'
  autoload :Expectation, 'lookout/expectation'
  autoload :Expectations, 'lookout/expectations'
  autoload :Literals, 'lookout/literals'
  autoload :Mock, 'lookout/mock'
  autoload :Not, 'lookout/not'
  autoload :Recorder, 'lookout/recorder'
  autoload :Recorders, 'lookout/recorders'
  autoload :Result, 'lookout/result'
  autoload :Results, 'lookout/results'
  autoload :Runners, 'lookout/runners'
  autoload :Stub, 'lookout/stub'
  autoload :Suite, 'lookout/suite'
  autoload :Tape, 'lookout/tape'
  autoload :UI, 'lookout/ui'
  autoload :Utilities, 'lookout/utilities'
  autoload :Version, 'lookout/version'
  autoload :XML, 'lookout/xml'
end

require 'lookout/object'

def Expectations(&block)
  Lookout::Runners::Console.suite_eval(&block)
end
