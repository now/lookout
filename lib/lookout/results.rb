# -*- coding: utf-8 -*-

module Lookout::Results
  autoload :Error, 'lookout/results/error'
  autoload :Failure, 'lookout/results/failure'
  autoload :Failures, 'lookout/results/failures'
  autoload :Fulfilled, 'lookout/results/fulfilled'

  autoload :Instance, 'lookout/results/instance'
  autoload :Unsuccessful, 'lookout/results/unsuccessful'
end
