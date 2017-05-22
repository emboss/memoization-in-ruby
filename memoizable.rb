require_relative 'memoizable/memory'

module Memoizable

  def memoized(name)
    memory = Memory.new

    prepend (Module.new do
      define_method(name) do |*args, &blk|
        return super(*args, &blk) if blk # do not memoize method calls with blocks

        memory.fetch(args) do
          super(*args)
        end
      end
    end)
  end

end

