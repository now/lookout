# -*- coding: utf-8 -*-

# Represents the expect block of {Expected::Lookout::Reception}s.
class Lookout::Expect::Lookout::Reception < Lookout::Expect::Object
  private

  # Delays the evaluation of the expect block until the difference check, at
  # which point {Expected::Lookout::Reception} will set up the proper
  # environment to perform the check.
  # @return [Proc] A proc that will evaluate the expect block when called
  # @extension
  def evaluate_block
    proc{ super }
  end
end
