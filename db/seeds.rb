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

# Destroying all instances of the database
puts "----------------------------------------------------------------"
puts " Destroying all instances"
puts "----------------------------------------------------------------"
AlbumCard.destroy_all
Card.destroy_all
Album.destroy_all
User.destroy_all
QuizAnswer.destroy_all
Quiz.destroy_all

puts "----------------------------------------------------------------"
puts "seeding the database"
puts "----------------------------------------------------------------"
teams_url = 'https://data.nba.net/data/10s/prod/v2/2021/teams.json'

teams_serialized = URI.open(teams_url).read
# teams_serialized = File.open('teams.json').read
teams_json = JSON.parse(teams_serialized)
teams_list = teams_json["league"]["standard"]

puts "----------------------------------------------------------------"
puts " Getting list of all teams"
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

seasons = ["2019", "2020", "2021"]

################################################################################################
# Looping through players by season
################################################################################################
seasons.each do |season|
  puts "----------------------------------------------------------------"
  puts "Season #{season}"
  puts "----------------------------------------------------------------"

  players_url = "https://data.nba.net/10s/prod/v1/#{season}/players.json"

  players_serialized = URI.open(players_url).read

  # players_serialized = File.open('players.json').read
  players_json = JSON.parse(players_serialized)
  players_list = players_json["league"]["standard"]

  players_list.each do |player|
    if TEAMS.key?(player["teamId"])
      puts "----------------------------------------------------------------"
      puts "Collecting data for players"
      puts "----------------------------------------------------------------"
      team = rosters["teams"].select { |t| t["id"] == player["teamId"] }
      player_to_add = Hash.new
      player_to_add["id"] = player["personId"]
      player_to_add["firstName"] = player["firstName"]
      player_to_add["lastName"] = player["lastName"]
      player_to_add["birthdate"] = player["dateOfBirthUTC"]
      player_to_add["height"] = player["heightMeters"]
      player_to_add["weight"] = player["weightKilograms"]
      player_to_add["position"] = player["teamSitesOnly"]["posFull"]
      player_to_add["team"] = TEAMS[player["teamId"]]
      player_to_add["image"] = "https://cdn.nba.com/headshots/nba/latest/1040x760/#{player['personId']}.png"

      # Add data from profile URL
      profile_url = "https://data.nba.net/data/10s/prod/v1/#{season}/players/#{player['personId']}_profile.json"
      # profile_url = "https://data.nba.net/data/10s/prod/v1/2021/players/1630554_profile.json"
      profile_serialized = URI.open(profile_url).read
      profile_json = JSON.parse(profile_serialized)
      pp profile_url
      pp profile_json
      p profile_json["league"]["standard"]["stats"]["regularSeason"]["season"].empty?
      if profile_json["league"]["standard"]["stats"]["regularSeason"]["season"].empty?
        player_to_add["points"] = 8.3
        player_to_add["rebounds"] = 4.9
        player_to_add["assists"] = 2.3
        player_to_add["minutes"] = 5.5
      else
        player_profile = profile_json["league"]["standard"]["stats"]["regularSeason"]["season"][0]["teams"][0]
        player_to_add["points"] = player_profile["ppg"]
        player_to_add["rebounds"] = player_profile["rpg"]
        player_to_add["assists"] = player_profile["apg"]
        player_to_add["minutes"] = player_profile["mpg"]
      end
      team[0]["players"] << player_to_add
      team[0]["players"] = team[0]["players"].sort_by { |player_ordered| player_ordered["minutes"].to_f }.reverse!
    end
  end

  index = 1
  rosters["teams"].each do |team|
    puts "----------------------------------------------------------------"
    puts "Iterating all teams"
    puts "----------------------------------------------------------------"
    team["players"][0..5].each do |player|
      puts "----------------------------------------------------------------"
      puts "Adding player with index #{index}"
      puts "----------------------------------------------------------------"
      name = "#{player['firstName']} #{player['lastName']}"
      team = player["team"]
      position = player["position"]
      birthdate = player["birthdate"]
      height = player["height"]
      weight = player["weight"]
      points = player["points"]
      rebounds = player["rebounds"]
      assists = player["assists"]
      image = player["image"]
      card = Card.new(name: name, birthdate: birthdate, height: height, weight: weight, season: season, image: image,
        position: position, points: points, rebounds: rebounds, assists: assists, team: team, index: index)
        card.save!
      index = index + 1
    end
  end

  # empty players for next season
  rosters["teams"].each do |team|
    team["players"] = []
  end
end

# adding a user
user = User.new({
                  email: "kobe1@lakers.com",
                  password: "password",
                  first_name: "Kobe",
                  last_name: "Bryant",
                  nickname: "Black Mamba"
                })
user.save!

# # create 3 albums for the user
seasons = Card.distinct.pluck(:season)
seasons.each { |season| Album.create!(season: season, user: user) }

# Add quizzes
quiz1 = Quiz.new(question: "Where was Michael Jordan born?")
quiz1.save!
QuizAnswer.create(quiz: quiz1, text: 'Brooklyn, NY', correct: true)
QuizAnswer.create(quiz: quiz1, text: 'Chicago, IL', correct: false)
QuizAnswer.create(quiz: quiz1, text: 'Atlanta, GH', correct: false)

quiz2 = Quiz.new(question: "What team won the championship in 1993?")
quiz2.save!
QuizAnswer.create(quiz: quiz2, text: 'Los Angeles Lakers', correct: false)
QuizAnswer.create(quiz: quiz2, text: 'Chicago Bulls', correct: true)
QuizAnswer.create(quiz: quiz2, text: 'Detroit Pistons', correct: false)

quiz3 = Quiz.new(question: "Who is the top scorer of all time?")
quiz3.save!
QuizAnswer.create(quiz: quiz3, text: 'Lebron James', correct: false)
QuizAnswer.create(quiz: quiz3, text: 'Michael Jordan', correct: false)
QuizAnswer.create(quiz: quiz3, text: 'Kareem Abdul-Jabbar', correct: true)
