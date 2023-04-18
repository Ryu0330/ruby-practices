input_array = ARGV[0].split(",")
input_array.map!(&:to_i)

p input_array

# boolean変数でストライクとスペアかその他を判定して、trueならストライクかどうかで二投目の判定
is_first_throw = True
count_frame = 0
is_knocked_down_all = False

input_array.each do |score|
  count_frame += 1 if is_first_throw
  if count_frame == 1 && is_first_throw = True
    score_this_frame = score
    is_first_throw = False
    next
  end

  if count_frame = 10

  end 

puts result
