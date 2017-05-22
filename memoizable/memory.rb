class Memory

  def initialize
    @values = {}
  end

  def fetch(args)
    unless @values.has_key?(args)
      @values[args] = yield
    end

    @values[args]
  end

end
