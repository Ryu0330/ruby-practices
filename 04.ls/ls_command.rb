# frozenl_string_iteral: true

def main
	files_array = []
	Dir.foreach('.') do |file|
		next if file.start_with?('.')
		files_array	<< file
	end
	puts files_array.sort
end


main
