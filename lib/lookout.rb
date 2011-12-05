# -*- coding: utf-8 -*-

module Lookout
  class << self
    def location(location)
      return nil, nil unless match = /\A(.*):(\d+)(?::in .*)?\z/.match(location)
      [match[1], match[2].to_i]
    end
  end

  load File.expand_path('../lookout/version.rb', __FILE__)

  Version.content[:requires].each do |requirement|
    require requirement
  end

  Version.content[:loads].each do |file|
    load File.expand_path('../%s' % file, __FILE__)
  end
end

class Object
  def to
    Lookout::Object::To.new(self)
  end

  def not
    Lookout::Object::Not.new(self)
  end

  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::State.new(self, file, line, &block)
  end
end
