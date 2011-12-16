# -*- coding: utf-8 -*-

class Lookout::Stub::Method
  def initialize(object, method, &body)
    @object, @method, @body = object, method.to_sym, body || Nil
    @yield = nil
    @defined = false
  end

  def yield(*values)
    @yield = Values.new(*values)
    self
  end

  def each(*values)
    @yield = Each.new(*values)
    self
  end

  def define
    return self if @defined
    meta.module_exec(@method, visibility, stash, self) do |method, visibility, stash, stub|
      alias_method stash, method if
        method_defined? method or private_method_defined? method
      define_method method do |*args, &block|
        stub.call(*args, &block)
      end
      send visibility, method
    end
    @defined = true
    self
  end

  def call(*args, &block)
    @yield.call(&block) if @yield and block
    @body.call(*args, &block)
  end

  def undefine
    return self unless @defined
    meta.module_exec(@method, stash) do |method, stash|
      remove_method method
      if method_defined? stash or private_method_defined? stash
        alias_method method, stash
        remove_method stash
      end
    end
    @defined = false
    self
  end

  private

  class Values
    def initialize(*values)
      @values = values
      @offset = -1
    end

    def next
      @offset = [@offset + 1, @values.count - 1].min
      @values[@offset]
    end

    def call
      yield(*self.next)
    end
  end

  class Each
    def initialize(*values)
      @values = values
    end

    def call
      @values.each do |value|
        yield value
      end
    end
  end

  Nil = proc{ Lookout::Stub::Object.new }

  def visibility
    meta.private_method_defined?(@method) ? :private :
      meta.protected_method_defined?(@method) ? :protected :
        :public
  end

  def stash
    :"__stubbed_method_#{@method}"
  end

  def meta
    Kernel == @object ? @object : (class << @object; self; end)
  end
end
