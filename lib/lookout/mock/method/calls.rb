# -*- coding: utf-8 -*-

module Lookout::Mock::Method::Calls
  autoload :Class, 'lookout/mock/method/calls/class'
  autoload :Exactly, 'lookout/mock/method/calls/exactly'
  autoload :Instance, 'lookout/mock/method/calls/instance'
  autoload :Lower, 'lookout/mock/method/calls/lower'
  autoload :Upper, 'lookout/mock/method/calls/upper'

  Error = ::Class.new(Lookout::Mock::Error)
end
