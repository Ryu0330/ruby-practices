# frozen_string_literal: true

COLUMN_COUNT = 3

def main
  files = fetch_files
  puts format_to_show(files)
end

def fetch_files
  Dir.foreach(dir_path).filter_map { |file| file unless file.start_with?('.') }
end

def dir_path
  ARGV[0] || '.'
end

def format_to_show(files)
  sorted_files = files.sort

  row_count = (files.size / COLUMN_COUNT.to_f).ceil

  column_width = sorted_files.max_by(&:length).length

  formatted_strings = []
  row_count.times do |row|
    same_row_files = []
    COLUMN_COUNT.times do |col|
      target_filename = sorted_files[row + col * row_count].to_s
      same_row_files << target_filename.ljust(column_width + 3)
    end
    formatted_strings << same_row_files.join
  end

  formatted_strings.join("\n")
end

main
