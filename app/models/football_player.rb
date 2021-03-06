require 'csv'

class FootballPlayer < ApplicationRecord

	PRIVATE_ATTRS = ["id", "created_at", "updated_at", "longest_rush_sortable_field"]
	ATTRIBUTES_TO_DISPLAY = attribute_names - PRIVATE_ATTRS
	SORTABLE_PARAMS = ["yards", "longest_rush", "total_rushing_touchdown"]
	SORTABLE_FIELD_LENGTH = 6
	SEARCHABLE_PARAMS = ["name"]
	EXPORT_SIZE = 200

  def self.create_from_json(json_record)
    params = {
		name: json_record["Player"],
      team: json_record["Team"],
      position: json_record["Pos"],
      rushing_attempts: json_record["Att"],
      rushing_attempts_per_game: json_record["Att/G"],
      yards: json_record["Yds"],
      yards_per_game: json_record["Yds/G"],
      average_yards: json_record["Avg"],
      total_rushing_touchdown: json_record["TD"],
      longest_rush: json_record["Lng"],
      longest_rush_sortable_field: prepare_longest_rush_sortable_field(json_record["Lng"]),
      rushing_first_down: json_record["1st"],
      rushing_first_down_percent: json_record["1st%"],
      rushing_20: json_record["20+"],
      rushing_40: json_record["40+"],
      rushing_fumble: json_record["FUM"]
	 }
	 FootballPlayer.create!(params)
  end
  
  def self.export_to_csv(search_params)
    CSV.generate(headers: true) do |csv|
      csv << ATTRIBUTES_TO_DISPLAY.map{|attrs| I18n.t("football_players.index.#{attrs}")}
      page = 1
      per_page = EXPORT_SIZE
      players = FootballPlayerSearch.new(search_params.merge("page" => page, "per_page" => per_page)).search
      while players.present? do
		   players.each do |player|
		     csv << ATTRIBUTES_TO_DISPLAY.map{|attrs| player.send(attrs.to_sym)}
		   end
		   page += 1
		   players = FootballPlayerSearch.new(search_params.merge("page" => page, "per_page" => per_page)).search
		end
    end
  end 
  
  def self.sortable?(attribute)
    SORTABLE_PARAMS.include?(attribute)
  end
  
  def self.searchable?(attribute)
    SEARCHABLE_PARAMS.include?(attribute)
  end
  
  def self.prepare_longest_rush_sortable_field(attribute)
      attribute = attribute.to_s
      has_t = attribute.last == "T"
      attribute = attribute[0...-1] if has_t
  		(SORTABLE_FIELD_LENGTH - attribute.length).times do 
  		  attribute = "0" + attribute
  		end
  		attribute += "T" if has_t
  		attribute
  end
end
