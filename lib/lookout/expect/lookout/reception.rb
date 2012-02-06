# -*- coding: utf-8 -*-

class Lookout::Expect::Lookout::Reception < Lookout::Expect::Object
  private

  def evaluate_block
    proc{ super }
  end
end
