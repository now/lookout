# -*- coding: utf-8 -*-

module Lookout
  autoload :Aphonic,                'lookout/aphonic'
  autoload :Expectation,            'lookout/expectation'
  autoload :Expectations,           'lookout/expectations'
  autoload :Recorder,               'lookout/recorder'
  autoload :Recorders,              'lookout/recorders'
  autoload :Result,                 'lookout/result'
  autoload :Results,                'lookout/results'
  autoload :ReverseResult,          'lookout/reverse_result'
  autoload :Runners,                'lookout/runners'
  autoload :Suite,                  'lookout/suite'
  autoload :UI,                     'lookout/ui'
  autoload :Version,                'lookout/version'
  autoload :XmlString,              'lookout/xml_string'

  def self.warn(message, invoker)
    Kernel.warn "\n%s: %s" % [invoker.sub(/:in `__instance_exec\d+'$/, ""), message]
  end
end

require 'lookout/object'
require 'lookout/module'
require 'lookout/regexp'
require 'lookout/range'
require 'lookout/string'

def Expectations(&block)
  Lookout::Runners::Console.suite_eval(&block)
end
