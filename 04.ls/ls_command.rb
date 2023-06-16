# frozen_string_literal: true
require 'optparse'

COLUMN_COUNT = 3

def main
  opt = OptionParser.new
  is_a_option = false
  opt.on('-a') { |v| is_a_option = v}
  opt.parse!(ARGV)
  p is_a_option
  if is_a_option
    p 'a option is true' 
    files = fetch_files(option: 'a')
  else
    files = fetch_files
  end
  puts format_to_show(files)
end

def fetch_files(option: '')
 case option
  when '' then
    Dir.foreach(dir_path).filter_map { |file| file unless file.start_with?('.') }
  when 'a' then
    p ARGV
    p Dir.foreach(dir_path).each
    Dir.foreach(dir_path).each
  end
end

def dir_path
  ARGV[0] || '.'
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
