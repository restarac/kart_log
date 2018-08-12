require 'rubygems'
require 'bundler'

Bundler.setup(:default)

def check_params!
  file_path = ARGV.first
  unless ARGV.first
    puts "Pass the input log file as a parameter"
    exit 1
  end
end

check_params!

puts "Begining the import of the #{file_path}"
summary = SummaryParser.from_file(file_path)


module SummaryParser
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

module Summary
  class Turn
    attr_reader :cod, :time, :speed

    def initialize(cod:, time:, speed:)
      @cod = cod
      @time = time
      @speed = speed
    end
  end

  class Pilot
    attr_reader :code, :name
    def initialize(code, name)
      @code = code
      @name = name
      @turns = []
    end

    def add_turn(turn)
      @turns << Turn.new(cod: turn, time: turn_time, speed: turn_speed)
    end

    def self.find_by(code_and_name)
      PilotRepository.pilot(code_and_name)
    end
  end

  class PilotRepository
    class << self
      def pilots
        @pilots ||= []
      end

      def pilot(code_and_name)
        code, name = code_and_name.split(' - ')

        persisted_pilot = pilots.select{ |p| p.code == cod }

        insert_new_pilot(code, name) unless persisted_pilot

        persisted_pilot
      end

      private

      def insert_new_pilot(code, name)
        persisted_pilot = Pilot.new(code, name)
        @pilots << persisted_pilot
      end
    end
  end

  class Record
    def initialize(hour:, pilot_cod_name:, turn:, turn_time:, turn_speed:)
      @hour = hour
      @pilot = Pilot.find_by(pilot_cod_name).add_turn(cod: turn, time: turn_time, speed: turn_speed)
    end
  end

  class Archive
    def initialize
      @values = []
    end

    def add(pilot)
      @values << record
    end
  end
end
