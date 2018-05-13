class OffsetCalculator

  def format_date(time = Time.new)
     date = time.strftime("%d%m%y")
  end

  def get_offsets(date = format_date)
    digits_arr = (date.to_i ** 2 %10_000).to_s.split("")
    digits_arr.map { |num| num.to_i }
  end
end
