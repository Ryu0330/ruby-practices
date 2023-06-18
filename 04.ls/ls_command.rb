# frozen_string_literal: true

require 'optparse'

COLUMN_COUNT = 3

def main
  files = if a_option?
            fetch_files(option: 'a')
          else
            fetch_files
          end
  puts format_to_show(files)
end

def a_option?
  has_a = false

  opt = OptionParser.new
  opt.on('-a') { |v| has_a = v }
  opt.parse!(ARGV)

  has_a
end

def fetch_files(option: '')
  case option
  when ''
    Dir.foreach(dir_path).filter_map { |file| file unless file.start_with?('.') }
  when 'a'
    Dir.foreach(dir_path).map { |file| file }
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
