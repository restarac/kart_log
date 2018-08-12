# frozen_string_literal: true

module Summary
  class Pilot
    attr_reader :code, :name

    def add_turn(number:, time:, speed:)
      @turns[number] = Turn.new(number: number, time: time, speed: speed)
    end

    def self.find_by(code_and_name)
      Repository.pilot(code_and_name)
    end

    def turns_count
      @turns.size
    end

    def time_total
      TimeTotalMilliseconds.new(@turns.values).calc
    end

    def average_speed
      AverageSpeedTotal.new(@turns.values).calc
    end

    private

    def initialize(code, name)
      @code = code
      @name = name
      @turns = {}
    end

    class AverageSpeedTotal
      def initialize(turns)
        @turns = turns
      end

      def calc
        return 0 if @turns.empty?
        sum_average_speed(&:speed) / @turns.size
      end

      def sum_average_speed
        @turns.inject(0) do |sum, turn|
          sum + yield(turn)
        end
      end
    end

    class TimeTotalMilliseconds
      SECOND_IN_MILLISECOND = 1000
      MINUTE_IN_MILLISECOND = 60 * SECOND_IN_MILLISECOND

      def initialize(turns)
        @turns = turns
      end

      def calc
        total_minutes = sum_time_total(&:minute) * MINUTE_IN_MILLISECOND
        total_second = sum_time_total(&:second)  * SECOND_IN_MILLISECOND
        total_millisecond = sum_time_total(&:millisecond)

        total_millisecond + total_second + total_minutes
      end

      def sum_time_total
        @turns.inject(0) do |sum, turn|
          sum + yield(turn)
        end
      end
    end

    class Repository
      class << self
        def reset_database
          @pilots = []
        end

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
