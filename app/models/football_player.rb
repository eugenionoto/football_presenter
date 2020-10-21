class FootballPlayer < ApplicationRecord


  def self.create_from_json(json_record)
    FootballPlayer.create!(
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
      rushing_first_down: json_record["1st"],
      rushing_first_down_percent: json_record["1st%"],
      rushing_20: json_record["20+"],
      rushing_40: json_record["40+"],
      rushing_fumble: json_record["FUM"]
	 )
  end 
end