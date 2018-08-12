# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'

Bundler.setup(:default)

require "lib/summary"
Bundler.require(:default)

file_path = ARGV.first

def check_params!(file_path)
  unless file_path
    puts "Pass the input log file as a parameter"
    exit 1
  end
end

check_params! file_path

puts "Begining the import of the #{file_path}"
summary = Summary::Parser.from_file(file_path)
puts summary.inspect
