# frozen_string_literal: true

require 'optparse'

COLUMN_COUNT = 3

def main
  options = load_options
  files = if options.has_key?(:a)
            fetch_files(option: 'a')
          elsif options.has_key?(:r)
            fetch_files(option: 'r')
          else
            fetch_files
          end
  sorted_files = if options.has_key?(:r)
                   files.sort.reverse
                 else
                   files.sort
                 end
  puts format_to_show(sorted_files)
end

def load_options
  options = {}

  opt = OptionParser.new
  opt.on('-a') { |v| options[:a] = v }
  opt.on('-r') { |v| options[:r] = v }
  opt.parse!(ARGV)

  options
end

def fetch_files(option: '')
  case option
  when '', 'r'
    Dir.foreach(dir_path).filter_map { |file| file unless file.start_with?('.') }
  when 'a'
    Dir.foreach(dir_path).map { |file| file }
  end
end

def dir_path
  ARGV[0] || '.'
end

def format_to_show(sorted_files)
  row_count = (sorted_files.size / COLUMN_COUNT.to_f).ceil
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
