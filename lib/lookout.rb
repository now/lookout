# -*- coding: utf-8 -*-

module Lookout
  class << self
    def location(location)
      return nil, nil unless match = /\A(.*):(\d+)(?::in .*)?\z/.match(location)
      [match[1], match[2].to_i]
    end
  end

  require 'lookout/version.rb'

  Version.content[:requires].each do |file|
    require '../%s' % file
  end
end
