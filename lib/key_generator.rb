class KeyGenerator

  def initialize(numbers = %w[1 2 3 4 5])
    @numbers = numbers
  end

  def get_key(key = @numbers.sample(5))
    key.join
  end
end
