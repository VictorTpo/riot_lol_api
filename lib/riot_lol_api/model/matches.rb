module RiotLolApi
  module Model
    class Match

      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

      def which_team_win
        self.teams.first.win? ? self.teams.first.team_id : self.teams.last.team_id
      end

    end
  end
end
