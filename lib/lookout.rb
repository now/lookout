# -*- coding: utf-8 -*-

module Lookout
  class << self
    def location(location)
      return nil, nil unless match = /\A(.*):(\d+)(?::in .*)?\z/.match(location)
      [match[1], match[2].to_i]
    end
  end

  load 'lookout/version.rb'

  Version.content[:loads].each do |file|
    load File.expand_path('../%s' % file, __FILE__)
  end
end
