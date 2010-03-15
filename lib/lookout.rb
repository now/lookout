# -*- coding: utf-8 -*-

module Lookout
  autoload :BlankSlate,             'lookout/blank_slate'
  autoload :Expectation,            'lookout/expectation'
  autoload :Expectations,           'lookout/expectations'
  autoload :Recorder,               'lookout/recorder'
  autoload :Recorders,              'lookout/recorders'
  autoload :Results,                'lookout/results'
  autoload :ReverseResult,          'lookout/reverse_result'
  autoload :Runners,                'lookout/runners'
  autoload :StandardError,          'lookout/standard_error'
  autoload :Suite,                  'lookout/suite'
  autoload :UI,                     'lookout/ui'
  autoload :Version,                'lookout/version'
  autoload :XmlString,              'lookout/xml_string'
end

require 'lookout/object'
require 'lookout/module'
require 'lookout/regexp'
require 'lookout/range'
require 'lookout/string'

def Expectations(&block)
  Lookout::Runners::Console.suite_eval(&block)
rescue
  Lookout::Runners::Console.do_not_run
  raise
end
