require "optparse"
require "date"

opt = OptionParser.new
input = {:year => Date.today.year, :month => Date.today.month}

opt.on("-y [VAL]", "--year [VAL]"){|v| v.to_i }
opt.on("-m [VAL]", "--month [VAL]"){|v| v.to_i }

opt.parse!(ARGV, into: input)

date = Date.new(input[:year], input[:month])
last_date = Date.new(input[:year], input[:month], -1).day.to_i

puts "#{date.month}月 #{date.year}".center(20)
puts "日 月 火 水 木 金 土"

start_dayofweek = date.wday
output_day = ""

for i in 1..last_date do
  forcus_day = Date.new(input[:year], input[:month], i)
  if forcus_day.wday == 0
    output_day = output_day.rjust(20) + "\n"

    if forcus_day.day == Date.today
      output_day += "\e[47m#{i}\e[0m".rjust(2)
    end
    
    output_day += "#{i}".rjust(2)
    
    next
  end

  if forcus_day == Date.today
    output_day += " \e[47m#{i}\e[0m"
    next
  end

  output_day += "#{i}".rjust(3)
  
end

puts output_day
