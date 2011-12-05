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
    Lookout::Expectations::Object.new(self, file, line, &block)
  end
end

class Array
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Array.new(self, file, line, &block)
  end
end

class TrueClass
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Boolean.new(self, file, line, &block)
  end
end

class FalseClass
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Boolean.new(self, file, line, &block)
  end
end

class Hash
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Hash.new(self, file, line, &block)
  end
end

class Module
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Module.new(self, file, line, &block)
  end
end

class Range
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Range.new(self, file, line, &block)
  end
end

class Regexp
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::Regexp.new(self, file, line, &block)
  end
end

class StandardError
  class << self
    def to_lookout_expectation(file, line, &block)
      Lookout::Expectations::Classes::StandardError.new(self, file, line, &block)
    end
  end

  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::StandardError.new(self, file, line, &block)
  end
end

class String
  def to_lookout_expectation(file, line, &block)
    Lookout::Expectations::String.new(self, file, line, &block)
  end
end
