# frozen_string_literal: true

module Summary
  module Parser
    KEY_NAMES = %i[hour pilot_cod_name turn turn_time turn_speed].freeze

    def self.from_file(file_path)
      archive = Summary::Archive.new
      lines = IO.readlines(file_path)
      lines.delete_at 0
      lines.each do |line|
        values = line.chomp.gsub(/\t/, '  ').gsub(/  +/, '#').split('#')
        hash_params = KEY_NAMES.zip(values).to_h
        record = Summary::Record.new(hash_params)
        archive.add record
      end

      archive
    end
  end
end
