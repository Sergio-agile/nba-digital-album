# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"
require "open-uri"

teams_url = 'https://data.nba.net/data/10s/prod/v2/2021/teams.json'

teams_serialized = URI.open(teams_url).read
teams_json = JSON.parse(teams_serialized)
teams_list = teams_json["league"]["standard"]

# grab teams => {1234: "chicago"}
new_team = Hash.new
teams_list.each do |team|
  if team["isNBAFranchise"] == true
    new_team[team["teamId"].to_i] = team["fullName"]
  end
end



players_url = 'https://data.nba.net/10s/prod/v1/2022/players.json'

players_serialized = URI.open(players_url).read
players_json = JSON.parse(players_serialized)
players_list = players_json["league"]["standard"]

# players_by_team = [{"chi": [{name: }]]
players_list.each do |player|
  if new_team.key?(player["teamId"].to_i)
    p team_id = player["teamId"].to_i
    p new_team[team_id]
  end
end

hash = {}
new_team.keys.each do |team_id|
  hash[team_id.value.to_s] = []
end

players_list.each do |player|
  if new_team.key?(player["team_id"].to_i)
    hash[team_id.value.to_s] << player
  end
end
