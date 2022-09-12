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

TEAMS = {}
teams_list.each do |team|
  if team["isNBAFranchise"] == true
    TEAMS[team["teamId"]] = team["fullName"]
  end
end

rosters = {}
TEAMS.each_value do |value|
  rosters[value] = {}
  rosters[value]["players"] = []
end

players_url = 'https://data.nba.net/10s/prod/v1/2021/players.json'

players_serialized = URI.open(players_url).read
players_json = JSON.parse(players_serialized)
players_list = players_json["league"]["standard"]

players_list.each do |player|
  if TEAMS.key?(player["teamId"])
    # p player
    player_to_add = Hash.new
    player_to_add["id"] = player["personId"]
    player_to_add["firstName"] = player["firstName"]
    player_to_add["lastName"] = player["lastName"]
    player_to_add["birthdate"] = player["dateOfBirthUTC"]
    player_to_add["height"] = player["heightMeters"]
    player_to_add["weight"] = player["weightKilograms"]
    player_to_add["position"] = player["teamSitesOnly"]["posFull"]
    player_to_add["points"] = 20.5
    player_to_add["rebounds"] = 8.3
    player_to_add["assists"] = 3.8
    player_to_add["team"] = TEAMS[player["teamId"]]
    rosters[player_to_add["team"]]["players"] << player_to_add
  end
end

# adding a user
user = User.new(email: "kobe1@lakers.com", password: "password", first_name: "Kobe", last_name: "Bryant", nickname: "Black Mamba");
user.save!

# create an album
album = Album.new(season: "Season 21/22", user: user)
album.save!

rosters.each do |roster|
  roster[1]["players"].each_with_index do |player, index|
    # p index
    if index < 6
      name = "#{player['firstName']} #{player['lastName']}"
      birthdate = player["birthdate"]
      height = player["height"]
      weight = player["weight"]
      position = player["position"]
      points = player["points"]
      rebounds = player["rebounds"]
      assists = player["assists"]
      team = player["team"]
      index = index + 1
      card = Card.new(name: name, birthdate: birthdate, height: height, weight: weight,
                    position: position, points: points, rebounds: rebounds, assists: assists, team: team, index: index, album: album)
      card.save!
    end
  end
end

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
