# -*- coding: utf-8 -*-

class Lookout::Stub::Method
  class Values
    def initialize(*values)
      @values = values
      @offset = -1
    end

    def next
      @offset = [@offset + 1, @values.count - 1].min
      @values[@offset]
    end
  end

  Nil = proc{ nil }

  def initialize(object, method, &body)
    @object, @method, @body = object, method.to_sym, body || Nil
    @yield = Values.new
    @defined = false
  end

  def yield(*values)
    @yield = Values.new(*values)
    self
  end

  def define
    return self if @defined
    define!
    @defined = true
    self
  end

  def call(*args)
    yield(*@yield.next) if block_given?
    @body.call(*args)
  end

  def undefine
    return self unless @defined
    undefine!
    @defined = false
    self
  end

private

  def define!
    meta.module_exec(@method, visibility, stash, self) do |method, visibility, stash, stub|
      alias_method stash, method if
        method_defined? method or private_method_defined? method
      define_method method do |*args, &block|
        stub.call(*args, &block)
      end
      send visibility, method
    end
  end

  def undefine!
    meta.module_exec(@method, stash) do |method, stash|
      remove_method method
      if method_defined? stash or private_method_defined? stash
        alias_method method, stash
        remove_method stash
      end
    end
  end

  def visibility
    meta.private_method_defined?(@method) ? :private :
      meta.protected_method_defined?(@method) ? :protected :
        :public
  end

  def stash
    :"__stubbed_method_#{@method}"
  end

  def meta
    (class << @object; self; end)
  end
end