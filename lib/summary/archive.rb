# frozen_string_literal: true

module Summary
  class Archive
    attr_reader :records, :pilots

    def initialize
      @records = []
      @pilots = {}
    end

    def add(record)
      @records << record
      @pilots[record.pilot.code] = record.pilot

      true
    end

    def ranking
      Summary::Ranking.new @pilots.values
    end
  end
end
