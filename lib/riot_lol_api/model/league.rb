require 'riot_lol_api/model/entry'
require 'riot_lol_api/model/mini_sery'

module RiotLolApi
  module Model
    class League

      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

    end
  end
end