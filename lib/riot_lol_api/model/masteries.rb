module RiotLolApi
  module Model
    class Mastery < OpenStruct

      def infos(data = nil, locale = 'fr_FR')
        build_data(data)
        # hack : set region by default euw
        response = Client.get("static-data/euw/v1.2/mastery/#{id}","global",data)
        return RiotLolApi::Model::Mastery.new(response.to_symbol) if response.present?
        nil
      end
      
      def build_data(data)
        return {locale: locale} if data.nil?
        data.merge!({locale: locale})
      end
    end
  end
end
