# frozen_string_literal: true

require 'environment'

file_path = ARGV.first

def check_params!(file_path)
  unless file_path
    puts 'Pass the input log file as a parameter'
    exit 1
  end
end

check_params! file_path

puts "Begining the import of the #{file_path}"
summary = Summary::Parser.from_file(file_path)
puts summary.ranking.to_s
