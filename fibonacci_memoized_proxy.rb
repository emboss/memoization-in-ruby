require_relative 'memoized_proxy'

class Fibonacci

  attr_reader :count

  def initialize
    @count = 0
  end

  def call(n)
    @count += 1

    return n if n < 2
    call(n - 1) + call(n - 2)
  end

end


original = Fibonacci.new
fib = MemoizedProxy.new(original)

puts fib.call(30)
puts fib.count
puts original.count

original = Fibonacci.new
puts original.call(30)
puts original.count

