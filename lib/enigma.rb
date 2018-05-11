class Enigma
  attr_reader   :key

  def new_key
    @key = [1,2,3,4,5].shuffle
  end

  def offset_digits
    time = Time.new.strftime("%m%e%y").to_i
    digits_arr = (time ** 2 %10_000).to_s.split("")
    digits_arr.map { |num| num.to_i }
  end
end
