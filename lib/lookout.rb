# -*- coding: utf-8 -*-

module Lookout
  autoload :Aphonic, 'lookout/aphonic'
  autoload :Diff, 'lookout/diff'
  autoload :Equality, 'lookout/equality'
  autoload :Expectation, 'lookout/expectation'
  autoload :Expectations, 'lookout/expectations'
  autoload :Output, 'lookout/output'
  autoload :Mock, 'lookout/mock'
  autoload :Recorder, 'lookout/recorder'
  autoload :Recorders, 'lookout/recorders'
  autoload :Result, 'lookout/result'
  autoload :Results, 'lookout/results'
  autoload :Runners, 'lookout/runners'
  autoload :Stub, 'lookout/stub'
  autoload :UI, 'lookout/ui'
  autoload :Version, 'lookout/version'
  autoload :Warning, 'lookout/warning'
  autoload :XML, 'lookout/xml'
  
  class << self
    def location(location)
      return nil, nil unless match = /\A(.*):(\d+)(?::in .*)?\z/.match(location)
      [match[1], match[2].to_i]
    end

    def runner(runner = nil)
      return @runner = runner if runner
      @runner ||= Lookout::Runners::Console.new.install
    end
  end
end

require 'lookout/object'

def Expectations(&block)
  Lookout.runner.expectations_eval(&block)
end
