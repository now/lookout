# -*- coding: utf-8 -*-

# Base module for results.
module Lookout::Result
  include Comparable

  # @param [String] file The expanded path of the file containing the expect
  #   block that this result pertains to
  # @param [Integer] line The line in _file_ on which the expectation that this
  #   result pertains to is defined
  def initialize(file, line)
    @file, @line = file, line
  end

  # @param [Result] other
  # @return [Integer] The comparison of the receiver’s {#file} and {#line}
  #   against those of _other_
  def <=>(other)
    return nil unless self.class == other.class
    (file <=> other.file).nonzero? or
      (line <=> other.line).nonzero? or
      0
  end

  alias eql? ==

  def hash
    @hash ||= [self.class, file, line].hash
  end

  # @return [String] A String formatted according to the GNU standard for
  #   command output
  def to_s
    '%s:%d' % [file, line]
  end

  # @return [String] The expanded path of the file containing the expect block
  #   that this result pertains to
  attr_reader :file

  # @return [Integer] The line in _file_ on which the expectation that this
  #   result pertains to is defined
  attr_reader :line
end
