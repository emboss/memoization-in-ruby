class Shared

  attr_reader :counter

  def initialize
    @counter = 0
    @mutex = Mutex.new
  end

  def expensive_computation
    @result ||= begin
      # To force the issue, uncomment
      # sleep 0.001
      @mutex.synchronize do
        @counter += 1
      end
      42
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

