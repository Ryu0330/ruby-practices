# frozen_string_literal: true
require 'optparse'

COLUMN_COUNT = 3

def main
  if is_a_option
    files = fetch_files
  else
    files = fetch_files
  end
  puts format_to_show(files)
end

def is_a_option
  input_option = analyze_argv
  p input_option[:]
  input_option[:]
end

def fetch_files
  Dir.foreach(dir_path).filter_map { |file| file unless file.start_with?('.') }
end

def dir_path
  ARGV[0] || '.'
end

def analyze_argv
  opt = OptionParser.new
  input = {}
  opt.on('-') {|v| input[path:] = v}
  opt.on('-a') {|v| input[a:] = v}

  opt.parse!(ARGV)
end

def format_to_show(files)
  sorted_files = files.sort
  row_count = (files.size / COLUMN_COUNT.to_f).ceil
  column_width = sorted_files.max_by(&:length).length

  rows = []
  row_count.times do |row_idx|
    columns = []
    COLUMN_COUNT.times do |col_idx|
      target_filename = sorted_files[row_idx + col_idx * row_count].to_s
      columns << target_filename.ljust(column_width + 3)
    end
    rows << columns.join
  end

  rows.join("\n")
end

main
