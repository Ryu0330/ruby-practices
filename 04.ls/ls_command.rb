# frozen_string_literal: true

require 'optparse'

COLUMN_COUNT = 3

def main
  options = load_options
  files = fetch_files

  unless options.key?(:a)
    files.filter! { |file| file unless file.start_with?('.') }
  end

  files = if options.key?(:r)
            files.sort.reverse
          else
            files.sort
          end

  puts format_to_show(files)
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
  Dir.foreach(dir_path).map { |file| file }
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
