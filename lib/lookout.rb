# -*- coding: utf-8 -*-

module Lookout
  autoload :BlankSlate,             'lookout/blank_slate'
  autoload :Expectation,            'lookout/expectation'
  autoload :Expectations,           'lookout/expectations'
  autoload :Recorder,               'lookout/recorder'
  autoload :Recorders,              'lookout/recorders'
  autoload :Results,                'lookout/results'
  autoload :ReverseResult,          'lookout/reverse_result'
  autoload :StandardError,          'lookout/standard_error'
  autoload :Suite,                  'lookout/suite'
  autoload :SuiteResults,           'lookout/suite_results'
  autoload :Version,                'lookout/version'
  autoload :XmlString,              'lookout/xml_string'
end

require 'lookout/object'
require 'lookout/module'
require 'lookout/regexp'
require 'lookout/range'
require 'lookout/string'

require 'lookout/suite_runner'

def Expectations(&block)
  Lookout::SuiteRunner.suite_eval(&block)
rescue
  Lookout::SuiteRunner.do_not_run
  raise
end
