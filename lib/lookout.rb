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

  def to_lookout_expected
    Lookout::Expected::Object.new(self)
  end
end

class Array
  def to_lookout_expected
    Lookout::Expected::Array.new(self)
  end
end

class TrueClass
  def to_lookout_expected
    Lookout::Expected::TrueClass.new(self)
  end
end

class FalseClass
  def to_lookout_expected
    Lookout::Expected::FalseClass.new(self)
  end
end

class Hash
  def to_lookout_expected
    Lookout::Expected::Hash.new(self)
  end
end

class Module
  def to_lookout_expected
    Lookout::Expected::Module.new(self)
  end
end

class Range
  def to_lookout_expected
    Lookout::Expected::Module.new(self)
  end
end

class Regexp
  def to_lookout_expected
    Lookout::Expected::Regexp.new(self)
  end
end

class StandardError
  class << self
    def to_lookout_expected
      Lookout::Expected::Classes::StandardError.new(self)
    end
  end

  def to_lookout_expected
    Lookout::Expected::StandardError.new(self)
  end
end

class String
  def to_lookout_expected
    Lookout::Expected::String.new(self)
  end
end
