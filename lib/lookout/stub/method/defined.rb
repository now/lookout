# -*- coding: utf-8 -*-

# Stub method that has been defined on its object.  May be {#call}ed and
# {#undefine}d.
class Lookout::Stub::Method::Defined
  include Lookout::Stub::Method

  # Sets up the method definition so that it’ll call {#call}, which calls
  # _body_.  This allows #call to be overridden in subclasses.
  # @param (see Method#initialize)
  def initialize(object, method, &body)
    super object, method, &body
    @definition = Definition.new(object, method){ |*args, &block|
      call(*args, &block)
    }
  end

  # @return [Boolean] True if the receiver’s definition `#==` that of _other_
  # @extension
  def ==(other)
    super and definition == other.definition
  end

  alias eql? ==

  def hash
    @hash ||= super ^ definition.hash
  end

  # @return [Undefined] The undefined version of this mock method after
  #   undefining it
  def undefine
    definition.undefine
    Undefined.new(object, method, &body)
  end

  protected

  attr_reader :definition

  private

  # @param [Object, …] *args
  # @param [Proc] &block
  # @return [Object] The result of calling the method definition with _args_
  #   and _block_
  def call(*args, &block)
    body.call(*args, &block)
  end
end
