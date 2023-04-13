1.upto(20) do |i|
  if i % 5 == 0 && i % 3 == 0 then
    puts "FizzBuzz"
  elsif i % 5 == 0 then
    puts "Buzz"
  elsif i % 3 == 0 then
    puts "Fizz"
  else 
    puts i
  end
end
