# frozen_string_literal: true

module Summary
  class Pilot
    attr_reader :code, :name
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
    
    class Repository
      class << self
        def pilots
          @pilots ||= []
        end
  
        def pilot(code_and_name)
          code, name = code_and_name.split(' – ')

          persisted_pilot = pilots.select{ |p| p.code == code }.first
  
          if persisted_pilot
            persisted_pilot
          else
            insert_new_pilot(code, name)
          end
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
