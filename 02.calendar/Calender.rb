require "optparse"
require "date"

def join_day_to_output_day(date, output_day, today_rjust_count, other_rjust_count)
  if date == Date.today
    output_day += "\e[7m#{Date.today.day}\e[0m".rjust(today_rjust_count)
  else
    output_day += "#{date.day}".rjust(other_rjust_count)
  end
end

opt = OptionParser.new
input = {:year => Date.today.year, :month => Date.today.month}

opt.on("-y [VAL]", "--year [VAL]"){|v| v.to_i }
opt.on("-m [VAL]", "--month [VAL]"){|v| v.to_i }

opt.parse!(ARGV, into: input)

first_date = Date.new(input[:year], input[:month])
last_date = Date.new(input[:year], input[:month], -1)

puts "#{first_date.month}月 #{first_date.year}".center(20)
puts "日 月 火 水 木 金 土"

output_day = ""

(first_date..last_date).each do |date|
  if date.sunday?
    output_day = output_day.rjust(20) + "\n"
    output_day = join_day_to_output_day(date, output_day, 10, 2)
  else
    output_day = join_day_to_output_day(date, output_day, 11, 3)
  end
end

puts output_day
