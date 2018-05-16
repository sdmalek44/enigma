class OffsetCalculator

  def get_offsets(date)
    digits_arr = (date.to_i ** 2 %10_000).to_s.split("")
    digits_arr.map { |num| num.to_i }
  end
end
