# -*- coding: utf-8 -*-

Expectations do
  if RUBY_VERSION < '1.9'
    expect [:__id__, :__send__, :object_id] do
      Object.instance_method(:methods).bind(Lookout::Aphonic.new).call.sort
    end
  else
    expect [:__send__, :object_id] do
      Object.instance_method(:methods).bind(Lookout::Aphonic.new).call.sort
    end
  end
end
