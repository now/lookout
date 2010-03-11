# -*- coding: utf-8 -*-

module Expectations
  autoload :BlankSlate,             'expectations/blank_slate'
  autoload :DelegateRecorder,       'expectations/delegate_recorder'
  autoload :Expectation,            'expectations/expectation'
  autoload :MockRecorder,           'expectations/mock_recorder'
  autoload :RecordedExpectation,    'expectations/recorded_expectation'
  autoload :Recorder,               'expectations/recorder'
  autoload :Results,                'expectations/results'
  autoload :ReverseResult,          'expectations/reverse_result'
  autoload :StandardError,          'expectations/standard_error'
  autoload :StateBasedExpectation,  'expectations/state_based_expectation'
  autoload :StateBasedRecorder,     'expectations/state_based_recorder'
  autoload :Suite,                  'expectations/suite'
  autoload :SuiteResults,           'expectations/suite_results'
  autoload :Version,                'expectations/version'
  autoload :XmlString,              'expectations/xml_string'
end

require 'expectations/object'
require 'expectations/module'
require 'expectations/regexp'
require 'expectations/range'
require 'expectations/string'

require 'expectations/suite_runner'

def Expectations(&block)
  Expectations::SuiteRunner.suite_eval(&block)
rescue
  Expectations::SuiteRunner.do_not_run
  raise
end
