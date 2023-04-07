21.times do |x|
    next if x==0
    
    if x%5==0 && x%3==0 then
        puts "FizzBuzz"
    elsif x%5==0 then
        puts "Buzz"
    elsif x%3==0 then
        puts "Fizz"
    else 
        puts x
    end
end
