class OffsetCalculator

  def todays_date
     Time.new.strftime("%d%m%y")
  end

  def get_offsets(date = todays_date)
    digits_arr = (date.to_i ** 2 %10_000).to_s.split("")
    digits_arr.map { |num| num.to_i }
  end
end
