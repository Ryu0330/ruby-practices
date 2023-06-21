# frozen_string_literal: true

require 'optparse'

COLUMN_COUNT = 3

def main
  options = load_options
  sorted_files = fetch_files.sort

  filtered_files = if options.key?(:a)
                     sorted_files
                   else
                     sorted_files.reject { |file| file.start_with?('.') }
                   end

  reversed_files = if options.key?(:r)
                     filtered_files.reverse
                   end

  puts format_to_show(reversed_files || filtered_files)
end

def load_options
  options = {}

  opt = OptionParser.new
  opt.on('-a') { |v| options[:a] = v }
  opt.on('-r') { |v| options[:r] = v }
  opt.parse!(ARGV)

  options
end

def fetch_files
  Dir.foreach(dir_path).to_a
end

def dir_path
  ARGV[0] || '.'
end

def format_to_show(files)
  row_count = (files.size / COLUMN_COUNT.to_f).ceil
  column_width = files.max_by(&:length).length

  rows = []
  row_count.times do |row_idx|
    columns = []
    COLUMN_COUNT.times do |col_idx|
      target_filename = files[row_idx + col_idx * row_count].to_s
      columns << target_filename.ljust(column_width + 3)
    end
    rows << columns.join
  end

  rows.join("\n")
end

main
