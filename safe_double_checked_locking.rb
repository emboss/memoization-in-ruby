require 'concurrent'

class Shared

  attr_reader :counter

  def initialize
    @counter = 0
    @mutex = Mutex.new
    @cache = Concurrent::Map.new
  end

  def expensive_computation
    @cache[:memoized] || @mutex.synchronize do
      @cache.compute_if_absent(:memoized) do
        @counter += 1
        @result = 42
      end
    end
  end

end

1000.times do
  shared = Shared.new

  5.times.map do
    Thread.new do
      shared.expensive_computation
    end
  end.map(&:join)

  if shared.counter != 1
    puts "Danger: #{shared.counter}"
  end
end

