# -*- coding: utf-8 -*-

# Base module for {Results}.
module Lookout::Result
  # Initializes the result pertaining to the expect block defined on LINE in
  # the expanded path to FILE.
  # @param [String] file The expanded path of the file containing the expect
  #   block that this result pertains to
  # @param [Integer] line The line in FILE on which the expectation that this
  #   result pertains to is defined
  Value(:file, :line, :comparable => true)
  public :file, :line

  # @return A String formatted according to the GNU standard for error messages
  def to_s; '%s:%d' % [file, line] end
end
