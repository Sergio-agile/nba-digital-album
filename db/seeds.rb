# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"
require "open-uri"
require 'pp'

puts "----------------------------------------------------------------"
puts "seeding the database"
puts "----------------------------------------------------------------"
# teams_url = 'https://data.nba.net/data/10s/prod/v2/2021/teams.json'

# teams_serialized = URI.open(teams_url).read
teams_serialized = File.open('teams.json').read
teams_json = JSON.parse(teams_serialized)
teams_list = teams_json["league"]["standard"]

puts "----------------------------------------------------------------"
puts "getting list of all teams"
puts "----------------------------------------------------------------"

TEAMS = {}
teams_list.each do |team|
  if team["isNBAFranchise"] == true
    TEAMS[team["teamId"]] = team["fullName"]
  end
end

puts "----------------------------------------------------------------"
puts "NBA TEAMS LIST"
puts "----------------------------------------------------------------"

pp TEAMS

puts "----------------------------------------------------------------"
puts "Generating hash with all data"
puts "----------------------------------------------------------------"

rosters = {}
rosters["teams"] = []

TEAMS.each do |team|
  rooster_team = {}
  rooster_team["id"] = team[0]
  rooster_team["name"] = team[1]
  rooster_team["players"] = []
  rosters["teams"] << rooster_team
end

# rosters["teams"].each do |team|
#   pp team["id"]
#   pp team["name"]
#   pp team["players"]
# end


# players_url = 'https://data.nba.net/10s/prod/v1/2021/players.json'

# players_serialized = URI.open(players_url).read

players_serialized = File.open('players.json').read
players_json = JSON.parse(players_serialized)
players_list = players_json["league"]["standard"]

players_list.each do |player|
  if TEAMS.key?(player["teamId"])
    team = rosters["teams"].select { |team| team["id"] == player["teamId"] }
    player_to_add = Hash.new
    player_to_add["id"] = player["personId"]
    player_to_add["firstName"] = player["firstName"]
    player_to_add["lastName"] = player["lastName"]
    player_to_add["birthdate"] = player["dateOfBirthUTC"]
    player_to_add["height"] = player["heightMeters"]
    player_to_add["weight"] = player["weightKilograms"]
    player_to_add["position"] = player["teamSitesOnly"]["posFull"]
    player_to_add["team"] = TEAMS[player["teamId"]]

    # Add data from profile URL
    profile_url = "https://data.nba.net/data/10s/prod/v1/2021/players/#{player['personId']}_profile.json"
    profile_serialized = URI.open(profile_url).read
    profile_json = JSON.parse(profile_serialized)
    debugger
    if profile_json["league"]["standard"]["stats"]["regularSeason"]["season"][0]["teams"][0].nil?
      player_to_add["points"] = 8.3
      player_to_add["rebounds"] = 4.9
      player_to_add["assists"] = 2.3
      player_to_add["minutes"] = 5.5
    else
      player_to_add["points"] = player_profile["ppg"]
      player_to_add["rebounds"] = player_profile["rpg"]
      player_to_add["assists"] = player_profile["apg"]
      player_to_add["minutes"] = player_profile["mpg"]
    end
    team[0]["players"] << player_to_add
    team[0]["players"] = team[0]["players"].sort_by { |player| player["minutes"] }.reverse!
  end
end


# get first 6 team["players"].first(6).each
rosters["teams"].each do |team|
  team["players"].first(6).each do |player|
    pp team["players"].size
    pp team["name"]
    pp team["id"]
    pp player["firstName"]
    pp player["id"]
  end
end

# players_list.each do |player|
#   if TEAMS.key?(player["teamId"])
#     # p player
#     player_to_add = Hash.new
#     player_to_add["id"] = player["personId"]
#     player_to_add["firstName"] = player["firstName"]
#     player_to_add["lastName"] = player["lastName"]
#     player_to_add["birthdate"] = player["dateOfBirthUTC"]
#     player_to_add["height"] = player["heightMeters"]
#     player_to_add["weight"] = player["weightKilograms"]
#     player_to_add["position"] = player["teamSitesOnly"]["posFull"]
#     player_to_add["points"] = 20.5
#     player_to_add["rebounds"] = 8.3
#     player_to_add["assists"] = 3.8
#     player_to_add["team"] = TEAMS[player["teamId"]]
#     rosters[player_to_add["team"]]["players"] << player_to_add
#   end
# end

# TODO: Seed albums from 2017. With Images?
# # adding a user
# user = User.new(email: "kobe1@lakers.com", password: "password", first_name: "Kobe", last_name: "Bryant", nickname: "Black Mamba");
# user.save!

# # create an album
# album = Album.new(season: "Season 21/22", user: user)
# album.save!

# rosters.each do |roster|
#   roster[1]["players"].each_with_index do |player, index|
#     # p index
#     if index < 6
#       name = "#{player['firstName']} #{player['lastName']}"
#       birthdate = player["birthdate"]
#       height = player["height"]
#       weight = player["weight"]
#       position = player["position"]
#       points = player["points"]
#       rebounds = player["rebounds"]
#       assists = player["assists"]
#       team = player["team"]
#       index = index + 1
#       # card = Card.new(name: name, birthdate: birthdate, height: height, weight: weight,
#       #               position: position, points: points, rebounds: rebounds, assists: assists, team: team, index: index, album: album)
#       # card.save!
#     end
#   end
# end



# TODO: Add real season stats to each player

# player_url = 'https://data.nba.net/data/10s/prod/v1/2022/players/1629029_profile.json'
# players_serialized = URI.open(players_url).read
# players_json = JSON.parse(players_serialized)
# players_list = players_json["league"]["standard"]["stats"]


# rosters.each do |roster|
#   team = roster[0]
#   roster[1]["players"].each do |player|
#     p player["id"]
#     profile_url = "https://data.nba.net/data/10s/prod/v1/2022/players/#{player["id"]}_profile.json"
#     profile_serialized = URI.open(profile_url).read
#     profile_json = JSON.parse(profile_serialized)
#     stats = players_json["league"]["standard"]["teamId"]
#     p stats
#     break
#   end
#   break
# end
#https://data.nba.net/data/10s/prod/v1/2022/players/#{player["id"]}_profile.json
#https://data.nba.net/data/10s/prod/v1/2021/players/1629027_profile.json
