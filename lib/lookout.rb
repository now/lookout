# -*- coding: utf-8 -*-

# The main namespace of the Lookout library.
module Lookout
  class << self
    def location(location)
      return nil, nil unless match = /\A(.*):(\d+)(?::in .*)?\z/.match(location)
      [match[1], match[2].to_i]
    end
  end

  load File.expand_path('../lookout/version.rb', __FILE__)
  Version.load
end

# Adds keyword methods “to” and “not” and #to_lookout_expected for Objects.
class Object
  # @return [Lookout::Object::To] A wrapper around the receiver that handles
  # “to” keywords, such as “receive”
  def to
    Lookout::Object::To.new(self)
  end

  # @return [Lookout::Object::To] A wrapper around the receiver that handles
  # “not” keywords, such as “to”, that’ll then handle “receive”
  def not
    Lookout::Object::Not.new(self)
  end

  # @return [Lookout::Expected::Object] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected
    Lookout::Expected::Object.new(self)
  end
end

# Adds #to_lookout_expected to Arrays for better difference generation.
class Array
  # @return [Lookout::Expected::Array] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected
    Lookout::Expected::Array.new(self)
  end
end

# Adds #to_lookout_expected to TrueClasses (`true`) for better difference
# generation.
class TrueClass
  # @return [Lookout::Expected::TrueClass] A wrapper around the receiver,
  #   making it an expected value
  def to_lookout_expected
    Lookout::Expected::TrueClass.new(self)
  end
end

# Adds #to_lookout_expected to FalseClasses (`false`) for better difference
# generation.
class FalseClass
  # @return [Lookout::Expected::FalseClass] A wrapper around the receiver,
  #   making it an expected value
  def to_lookout_expected
    Lookout::Expected::FalseClass.new(self)
  end
end

# Adds #to_lookout_expected to Hashes for better difference generation.
class Hash
  # @return [Lookout::Expected::Hash] A wrapper around the receiver, making it
  #   an expected value
  def to_lookout_expected
    Lookout::Expected::Hash.new(self)
  end
end

# Adds #to_lookout_expected to Modules for better difference generation.
class Module
  # @return [Lookout::Expected::Module] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected
    Lookout::Expected::Module.new(self)
  end
end

# Adds #to_lookout_expected to Ranges for better difference generation.
class Range
  # @return [Lookout::Expected::Range] A wrapper around the receiver, making it
  #   an expected value
  def to_lookout_expected
    Lookout::Expected::Range.new(self)
  end
end

# Adds #to_lookout_expected to Regexps for better difference generation.
class Regexp
  # @return [Lookout::Expected::Regexps] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected
    Lookout::Expected::Regexp.new(self)
  end
end

# Adds #to_lookout_expected to Exceptions and their classes for better
# difference generation.
class Exception
  class << self
    # @return [Lookout::Expected::Classes::Exception] A wrapper around the
    #   receiver, making it an expected value
    def to_lookout_expected
      Lookout::Expected::Classes::Exception.new(self)
    end
  end

  # @return [Lookout::Expected::Exception] A wrapper around the receiver,
  #   making it an expected value
  def to_lookout_expected
    Lookout::Expected::Exception.new(self)
  end
end

# Adds #to_lookout_expected to Strings for better difference generation.
class String
  # @return [Lookout::Expected::String] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected
    Lookout::Expected::String.new(self)
  end
end

# Adds #to_lookout_expected to Symbols for query method expectations and better
# difference generation.
class Symbol
  # @return [Lookout::Expected::Smybol] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected
    Lookout::Expected::Symbol.new(self)
  end
end

def Expectations(&block)
  Lookout::Expectations.evaluate(Lookout.location(caller.first).first, &block)
  self
end
