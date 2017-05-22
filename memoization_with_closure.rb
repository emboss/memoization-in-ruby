def expensive_computation
  puts "Computing..."
  sleep 1
  42
end

def memoized_method
  expensive_computation.tap do |value|
    define_method :memoized_method do
      value
    end
  end
end

10.times { puts memoized_method }

