# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::State < Lookout::Expected::Object
  def initialize(subject, verify)
    super subject
    @verify = verify
  end

  def difference(other)
    @verify.call
    nil
  rescue Lookout::State::Error => e
    Lookout::Difference::Lookout::State.new(e.message)
  end
end
