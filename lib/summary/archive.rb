# frozen_string_literal: true

module Summary
  class Archive
    def initialize
      @values = []
    end

    def add(pilot)
      @values << pilot
    end
  end
end
