# -*- coding: utf-8 -*-

Expectations do
  if RUBY_VERSION < '1.9'
    expect ['__id__', '__send__', 'object_id'] do
      Lookout::Aphonic.instance_methods.sort
    end
  else
    expect [:__send__, :object_id] do
      Lookout::Aphonic.instance_methods.sort
    end
  end

  expect true do
    class Object; def lookout_test_temporary_method() end end
    begin
      Object.method_defined? :lookout_test_temporary_method
    ensure
      class Object; remove_method :lookout_test_temporary_method end
    end
  end

  expect false do
    class Object; def lookout_test_temporary_method() end end
    begin
      Lookout::Aphonic.method_defined? :lookout_test_temporary_method
    ensure
      class Object; remove_method :lookout_test_temporary_method end
    end
  end
end
