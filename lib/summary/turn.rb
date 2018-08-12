# frozen_string_literal: true

module Summary
  class Turn
    attr_reader :cod, :minute, :second, :millisecond, :speed

    def initialize(cod:, time:, speed:)
      @cod = cod.to_i
      @minute, @second, @millisecond = time.split(/[:|\.]/).map(&:to_i)
      @speed = speed.tr(',', '.').to_f
    end
  end
end
