# -*- coding: utf-8 -*-

module Lookout
  class << self
    # @private
    def location(location)
      return nil, nil unless match = /\A(.*):(\d+)(?::in .*)?\z/.match(location)
      [match[1], match[2].to_i]
    end
  end

  load File.expand_path('../lookout/version.rb', __FILE__)
  Version.load
end

# @private
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

# @private
class Array
  def to_lookout_expected
    Lookout::Expected::Array.new(self)
  end
end

# @private
class TrueClass
  def to_lookout_expected
    Lookout::Expected::TrueClass.new(self)
  end
end

# @private
class FalseClass
  def to_lookout_expected
    Lookout::Expected::FalseClass.new(self)
  end
end

# @private
class Hash
  def to_lookout_expected
    Lookout::Expected::Hash.new(self)
  end
end

# @private
class Module
  def to_lookout_expected
    Lookout::Expected::Module.new(self)
  end
end

# @private
class Range
  def to_lookout_expected
    Lookout::Expected::Range.new(self)
  end
end

# @private
class Regexp
  def to_lookout_expected
    Lookout::Expected::Regexp.new(self)
  end
end

# @private
class Exception
  class << self
    def to_lookout_expected
      Lookout::Expected::Classes::Exception.new(self)
    end
  end

  def to_lookout_expected
    Lookout::Expected::Exception.new(self)
  end
end

# @private
class String
  def to_lookout_expected
    Lookout::Expected::String.new(self)
  end
end

# @private
class Symbol
  def to_lookout_expected
    Lookout::Expected::Symbol.new(self)
  end
end

# @private
def Expectations(&block)
  Lookout::Expectations.evaluate(Lookout.location(caller.first).first, &block)
  self
end
