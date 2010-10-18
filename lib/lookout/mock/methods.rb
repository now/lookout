# -*- coding: utf-8 -*-

class Lookout::Mock::Methods < Lookout::Stub::Methods
  def verify
    @methods.each(&:verify)
    self
  end
end
