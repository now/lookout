# -*- coding: utf-8 -*-

module Lookout::Results::Error
  extend Lookout::Result

  is :error

  attr_reader :exception
end
