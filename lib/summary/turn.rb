# frozen_string_literal: true

module Summary
  class Turn
    attr_reader :cod, :time, :speed

    def initialize(cod:, time:, speed:)
      @cod = cod
      @time = time
      @speed = speed
    end
  end
end
