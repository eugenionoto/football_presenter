class FootballPlayersController < ApplicationController
  helper_method :sort_column, :sort_direction

	def index
		@search_params = search_params
		@football_players = FootballPlayerSearch.new(@search_params).search
		@display_attributes = FootballPlayer::ATTRIBUTES_TO_DISPLAY
		
		respond_to do |format|
		  format.html
		  format.csv {send_data FootballPlayer.export_to_csv(@search_params), filename: "player-stats-#{Date.today}.csv"}
		end
	end
	

	private
	
	def search_params
	  params.to_enum.to_h.except(:controller, :action)
	end
	
	def sort_column
	  params[:sort]
	end
	
	def sort_direction
		params[:direction] || "asc"
	end
end
