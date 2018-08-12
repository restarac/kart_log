# frozen_string_literal: true

module Summary
  class Record
    attr_reader :pilot, :hour

    def initialize(hour:, pilot_cod_name:, turn:, turn_time:, turn_speed:)
      @hour = hour

      @pilot = Pilot.find_by(pilot_cod_name)
      @pilot.add_turn(number: turn, time: turn_time, speed: turn_speed)
    end
  end
end
