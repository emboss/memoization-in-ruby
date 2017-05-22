require_relative 'memoizable'

class Fibonacci
  extend Memoizable

  attr_reader :counter

  def initialize
    @counter = 0
  end

  memoized def call(n)
    @counter += 1
    return n if n < 2
    call(n - 1) + call(n - 2)
  end
end

fib = Fibonacci.new
puts fib.call(30)
puts fib.counter

