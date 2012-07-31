# -*- coding: utf-8 -*-

# Main namespace of the Lookout library.
#
# {Expectations} is the main entry point to the library, representing the
# “Expectations” keyword in expectation files and allowing such files to be
# loaded, enumerating the {Expect} blocks found in such files.  Each such block
# has an {Expected} value that’s an {Actual} result wrapper, a {Literal}, an
# expected {Output}, an expected {Warning}, an expected method {Reception}, or
# any {::Object} really, which it’ll compare to the actual result of executing
# the block, reporting any {Difference}s – which may, in turn, be shown as
# {Diff}s – as its {Result}.
#
# To help out, {Stub stub} and {Mock mock} objects may be created.
# Furthermore, all ::Objects have been extended to support easy creation of
# expected method {Reception}s, using a simple {Object domain-specific
# language} that uses {Aphonic} receivers to gather the necessary information.
#
# To avoid failing while trying to report failures, non-failing access to
# {Exception}s and {Inspect}ions of objects is used, as well as making sure to
# {Encode} any output properly.
#
# There’s a command-line interface defined in {Interfaces::Commandline} that can
# be used by other interfaces that want to invoke Lookout on a set of files.
# It’s used by the {http://disu.se/software/lookout-rake Lookout-Rake} library.
#
# Plugins should place their namespace under the {Lookout::Plugins} namespace.
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
  def to; Lookout::Object::To.new(self) end

  # @return [Lookout::Object::To] A wrapper around the receiver that handles
  # “not” keywords, such as “to”, that’ll then handle “receive”
  def not; Lookout::Object::Not.new(self) end

  # @return [Lookout::Expected::Object] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected; Lookout::Expected::Object.new(self) end
end

# Adds #to_lookout_expected to Arrays for better difference reports.
class Array
  # @return [Lookout::Expected::Array] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected; Lookout::Expected::Array.new(self) end
end

# Adds #to_lookout_expected to TrueClasses (`true`) for better difference
# reports.
class TrueClass
  # @return [Lookout::Expected::TrueClass] A wrapper around the receiver,
  #   making it an expected value
  def to_lookout_expected; Lookout::Expected::TrueClass.new(self) end
end

# Adds #to_lookout_expected to FalseClasses (`false`) for better difference
# reports.
class FalseClass
  # @return [Lookout::Expected::FalseClass] A wrapper around the receiver,
  #   making it an expected value
  def to_lookout_expected; Lookout::Expected::FalseClass.new(self) end
end

# Adds #to_lookout_expected to Hashes for better difference reports.
class Hash
  # @return [Lookout::Expected::Hash] A wrapper around the receiver, making it
  #   an expected value
  def to_lookout_expected; Lookout::Expected::Hash.new(self) end
end

# Adds #to_lookout_expected to Modules for better difference reports.
class Module
  # @return [Lookout::Expected::Module] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected; Lookout::Expected::Module.new(self) end
end

# Adds #to_lookout_expected to Ranges for better difference reports.
class Range
  # @return [Lookout::Expected::Range] A wrapper around the receiver, making it
  #   an expected value
  def to_lookout_expected; Lookout::Expected::Range.new(self) end
end

# Adds #to_lookout_expected to Regexps for better difference reports.
class Regexp
  # @return [Lookout::Expected::Regexps] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected; Lookout::Expected::Regexp.new(self) end
end

# Adds #to_lookout_expected to Exceptions and their classes for better
# difference reports.
class Exception
  class << self
    # @return [Lookout::Expected::Classes::Exception] A wrapper around the
    #   receiver, making it an expected value
    def to_lookout_expected; Lookout::Expected::Classes::Exception.new(self) end
  end

  # @return [Lookout::Expected::Exception] A wrapper around the receiver,
  #   making it an expected value
  def to_lookout_expected; Lookout::Expected::Exception.new(self) end
end

# Adds #to_lookout_expected to Strings for better difference reports.
class String
  # @return [Lookout::Expected::String] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected; Lookout::Expected::String.new(self) end
end

# Adds #to_lookout_expected to Symbols for query method expectations and better
# difference reports.
class Symbol
  # @return [Lookout::Expected::Smybol] A wrapper around the receiver, making
  #   it an expected value
  def to_lookout_expected; Lookout::Expected::Symbol.new(self) end
end

def Expectations(&block)
  Lookout::Expectations.evaluate Lookout.location(caller.first).first, &block
  self
end
