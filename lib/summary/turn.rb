# frozen_string_literal: true

module Summary
  class Turn
    attr_reader :number, :minute, :second, :millisecond, :speed

    def initialize(number:, time:, speed:)
      @number = number.to_i
      @minute, @second, @millisecond = time.split(/[:|\.]/).map(&:to_i)
      @speed = speed.tr(',', '.').to_f
    end
  end
end
