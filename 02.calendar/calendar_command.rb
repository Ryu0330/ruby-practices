require "optparse"
require "date"

def format_date(date)
  if date.sunday?
    rjust_count = 2
  else
    rjust_count = 3
  end

  if date == Date.today
    "\e[7m#{Date.today.day}\e[0m".rjust(rjust_count + 8)
  else
    "#{date.day}".rjust(rjust_count)
  end
end

opt = OptionParser.new
input = {year: Date.today.year, month: Date.today.month}

opt.on("-y [VAL]", "--year [VAL]"){|v| v.to_i }
opt.on("-m [VAL]", "--month [VAL]"){|v| v.to_i }

opt.parse!(ARGV, into: input)

first_date = Date.new(input[:year], input[:month])
last_date = Date.new(input[:year], input[:month], -1)

puts "#{first_date.month}月 #{first_date.year}".center(20)
puts "日 月 火 水 木 金 土"

output_day = ""
if not first_date.sunday?
  output_day += "  " + "   " * (first_date.wday - 1)
end

(first_date..last_date).each do |date|
  output_day += format_date(date)

  if date.saturday?
    output_day += "\n"
  end
end

puts output_day

