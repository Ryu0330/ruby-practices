# frozen_string_literal: true

COLUMN_WIDTH = 3

def main
  files_array = fetch_files_array
  puts format_to_show(files_array)
end

def fetch_files_array
  files_array = []
  dir_path = configure_dir
  Dir.foreach(dir_path) do |file|
    next if file.start_with?('.')

    files_array	<< file
  end
  files_array
end

def configure_dir
  ARGV[0] ||= '.'
end

def format_to_show(files_array)
  files_array.sort!

  row_count = if (files_array.size % COLUMN_WIDTH).zero?
                files_array.size / COLUMN_WIDTH
              else
                files_array.size / COLUMN_WIDTH + 1
              end

  longest_number_among_filename = files_array.max_by(&:length).length

  formatted_string = ''
  row_count.times do |row|
    COLUMN_WIDTH.times do |col|
      formatted_string += files_array[row + col * row_count].to_s.ljust(longest_number_among_filename + 3)
    end
    formatted_string += "\n"
  end

  formatted_string
end

main
