require 'riot_lol_api/model/player_stat_summaries'
require 'riot_lol_api/model/player_stat_ranks'
require 'riot_lol_api/model/pages'
require 'riot_lol_api/model/games'
require 'riot_lol_api/model/leagues'
require 'riot_lol_api/model/matches'
require 'riot_lol_api/model/participants'
require 'riot_lol_api/model/timelines'
require 'riot_lol_api/model/creepspermindeltas'
require 'riot_lol_api/model/xppermindeltas'
require 'riot_lol_api/model/goldpermindeltas'
require 'riot_lol_api/model/csdiffpermindeltas'
require 'riot_lol_api/model/xpdiffpermindeltas'
require 'riot_lol_api/model/damagetakenpermindeltas'
require 'riot_lol_api/model/damagetakendiffpermindeltas'
require 'riot_lol_api/model/participantidentities'
require 'riot_lol_api/model/players'
require 'riot_lol_api/model/observers'
require 'riot_lol_api/model/game_lists'
require 'riot_lol_api/model/banned_champions'
require 'riot_lol_api/model/teams'
require 'riot_lol_api/model/bans'


module RiotLolApi
  module Model
	class Summoner

		include RiotLolApi::HelperClass

		# attr needs @id, @region
		SEASON_TAB = %Q{SEASON2015,SEASON2014,SEASON3}
		def initialize(options = {})
			options.each do |key, value|
				self.class.send(:attr_accessor, key.to_sym)
				instance_variable_set("@#{key}", value)
			end
		end

		def masteries
			response = Client.get("#{@region}/v1.4/summoner/#{@id}/masteries",@region)
			unless response.nil?
				tab_pages = Array.new
				response[self.id.to_s]['pages'].each do |page|
					tab_pages << RiotLolApi::Model::Page.new(page.to_symbol)
				end
				tab_pages
			else
				nil
			end
		end

		def runes
			response = Client.get("#{@region}/v1.4/summoner/#{@id}/runes", @region)
			unless response.nil?
				tab_pages = Array.new
				response[self.id.to_s]['pages'].each do |page|
					tab_pages << RiotLolApi::Model::Page.new(page.to_symbol)
				end
				tab_pages
			else
				nil
			end
		end

		def games
			response = Client.get("#{@region}/v1.3/game/by-summoner/#{@id}/recent", @region)
			unless response.nil?
				games = response['games']

				tab_games = Array.new
				games.each do |game|
					tab_games << RiotLolApi::Model::Game.new(game.to_symbol)
				end

				tab_games
			else
				nil
			end
		end

		def stat_summaries season="SEASON2015"
			response = Client.get("#{@region}/v1.3/stats/by-summoner/#{@id}/summary",@region,{:season => season})
			unless response.nil?
				stat_summaries = response['playerStatSummaries']

				tab_stat_summaries = Array.new
				stat_summaries.each do |stat_summary|
					tab_stat_summaries << RiotLolApi::Model::PlayerStatSummary.new(stat_summary.to_symbol)
				end

				tab_stat_summaries
			else
				nil
			end
		end

		def stat_ranks season="SEASON2015"
			response = Client.get("#{@region}/v1.3/stats/by-summoner/#{@id}/ranked",@region,{:season => season})
			unless response.nil?
				stat_ranks = response['champions']

				tab_stat_ranks = Array.new
				stat_ranks.each do |stat_rank|
					tab_stat_ranks << RiotLolApi::Model::PlayerStatRank.new(stat_rank.to_symbol)
				end

				tab_stat_ranks
			else
				nil
			end
		end

		def get_league_stats
			response = Client.get("#{@region}/v2.5/league/by-summoner/#{@id}/entry",@region)
			unless response.nil?
				league_stats = response["#{@id}"]

				tab_league_stats = Array.new
				league_stats.each do |league_stat|
					tab_league_stats << RiotLolApi::Model::League.new(league_stat.to_symbol)
				end

				tab_league_stats
			else
				nil
			end
		end

		def get_match_history
			response = Client.get("#{@region}/v2.2/matchhistory/#{@id}",@region)
			unless response.nil?
				match_histories = response["matches"]

				tab_match_histories = Array.new
				match_histories.each do |match_history|
					tab_match_histories << RiotLolApi::Model::Match.new(match_history.to_symbol)
				end

				tab_match_histories
			else
				nil
			end
		end

		def current_game platform_id='EUW1'
			response = Client.get("observer-mode/rest/consumer/getSpectatorGameInfo/#{platform_id}/#{@id}",@region,nil,'api.pvp.net/')
			unless response.nil?
				RiotLolApi::Model::Game.new(response.to_symbol)
			else
				nil
			end
		end

		def profile_icon
			"#{RiotLolApi::Client.realm["cdn"]}/#{RiotLolApi::Client.realm["v"]}/img/profileicon/#{self.profile_icon_id}.png"
		end
	end
  end
end
