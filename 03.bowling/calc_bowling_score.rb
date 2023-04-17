input_array = ARGV[0].split(",")
input_array.map!(&:to_i)

p input_array

# boolean変数でストライクとスペアかその他を判定して、trueならストライクかどうかで二投目の判定
