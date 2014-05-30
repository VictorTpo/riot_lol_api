require 'riot_lol_api/model/block'

module RiotLolApi
  module Model
    class Recommended

      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

    end
  end
end