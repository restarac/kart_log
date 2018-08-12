# frozen_string_literal: true

module Summary
  class Pilot
    attr_reader :code, :name
    SECOND_IN_MILLISECOND = 1000
    MINUTE_IN_MILLISECOND = 60 * SECOND_IN_MILLISECOND
    def initialize(code, name)
      @code = code
      @name = name
      @turns = []
    end

    def add_turn(cod:, time:, speed:)
      @turns << Turn.new(cod: cod, time: time, speed: speed)
    end

    def self.find_by(code_and_name)
      Repository.pilot(code_and_name)
    end

    def time_total
      total_minutes = sum_time_total(&:minute) * MINUTE_IN_MILLISECOND
      total_second = sum_time_total(&:second)  * SECOND_IN_MILLISECOND
      total_millisecond = sum_time_total(&:millisecond)

      total_millisecond + total_second + total_minutes
    end

    private

    def sum_time_total
      @turns.inject(0) do |sum, turn|
        sum + yield(turn)
      end
    end

    class Repository
      class << self
        def pilots
          @pilots ||= []
        end

        def pilot(code_and_name)
          code, name = code_and_name.split(' – ')

          persisted_pilot = pilots.select { |p| p.code == code }.first

          persisted_pilot || insert_new_pilot(code, name)
        end

        private

        def insert_new_pilot(code, name)
          persisted_pilot = Pilot.new(code, name)
          @pilots << persisted_pilot
          persisted_pilot
        end
      end
    end
  end
end
