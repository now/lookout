# -*- coding: utf-8 -*-

# Base module for {Results}.
module Lookout::Result
  # Initializes the result pertaining to the expect block defined on _line_ in
  # the expanded path to _file_.
  # @param [String] file The expanded path of the file containing the expect
  #   block that this result pertains to
  # @param [Integer] line The line in _file_ on which the expectation that this
  #   result pertains to is defined
  Value(:file, :line, :comparable => true)
  public :file, :line

  # @return [String] A String formatted according to the GNU standard for
  #   error messages
  def to_s
    '%s:%d' % [file, line]
  end
end
