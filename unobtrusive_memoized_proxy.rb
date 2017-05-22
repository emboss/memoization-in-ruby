require_relative 'memoizable'

class UnobtrusiveMemoizedProxy

  def initialize(object, memoize: object.public_methods)
    @delegate = create_memoized_delegate(
      object,
      Array(memoize)
    )
  end

  def respond_to_missing?(name, include_private=false)
    @delegate.respond_to?(name, include_private)
  end

  def method_missing(name, *args, &block)
    @delegate.send(name, *args, &block)
  end

  private

  def create_memoized_delegate(object, memoized_methods)
    object.dup.tap do |clone|
      clone.singleton_class.instance_eval do
        extend Memoizable
        memoized_methods.each do |method|
          memoized(method)
        end
      end
    end
  end

end

