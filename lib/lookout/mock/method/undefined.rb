# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Undefined < Lookout::Stub::Method::Undefined
  include Lookout::Mock::Method

  private

  def defined
    Defined.new(@object, @method, @calls, *@args, &@body)
  end
end