# frozen_string_literal: true

module Summary
  class Ranking
    attr_reader :pilots

    def initialize(pilots, threshold_turn: 4)
      @pilots = Array.new(pilots)
      @pilots.delete_if { |p| p.turns_count < threshold_turn }
    end

    def show
      return "No pilots have finished yet" if @pilots.empty?

      sorted = @pilots.sort_by {|p| p.time_total}

      sorted_result = sorted.map.with_index do |p,index|
        "#{index+1};#{p.code} - #{p.name};#{p.time_total};#{p.average_speed}"
      end

      output = ['Position;Pilot;Time Total;Average Speed'] + sorted_result
      output.join("\n")
    end
  end
end
