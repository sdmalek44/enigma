class Enigma

  def get_offsets(time = Time.new.strftime("%m%e%y"))
    digits_arr = (time.to_i ** 2 %10_000).to_s.split("")
    digits_arr.map { |num| num.to_i }
  end

  def get_key
    ("1" .. "5").to_a.shuffle
  end

  def get_rotations(key = get_key)
    rotations = []
    rotations << (key[0] + key[1]).to_i
    rotations << (key[1] + key[2]).to_i
    rotations << (key[2] + key[3]).to_i
    rotations << (key[3] + key[4]).to_i
  end
end
