# frozen_string_literal: true

module Summary
  module Parser
    KEY_NAMES = [:hour, :pilot_cod_name, :turn, :turn_time, :turn_speed]

    def from_file(file_path)
      archive = Summary::Archive.new

      IO.readlines(file_path).each do |line|
        values = line.gsub(/\t/, '  ').gsub(/  +/, '#').split('#')
        hash_params = [KEY_NAMES, values].to_h
        record = Summary::Record.new(hash_params)
        archive.add record
      end

      archive
    end
  end
end
